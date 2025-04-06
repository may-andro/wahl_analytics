import 'dart:async';
import 'dart:io';

import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wahl_analytics/src/feature/career/domain/domain.dart';
import 'package:wahl_analytics/src/feature/career/presentation/careers_request/bloc/careers_request_event.dart';
import 'package:wahl_analytics/src/feature/career/presentation/careers_request/bloc/careers_request_state.dart';
import 'package:wahl_analytics/src/feature/career/presentation/careers_request/bloc/snack_bar_message_state.dart';
import 'package:wahl_analytics/src/feature/file_picker/file_picker.dart';
import 'package:wahl_analytics/src/feature/url_handler/url_handler.dart';

class CareersRequestBloc
    extends Bloc<CareersRequestEvent, CareersRequestState> {
  CareersRequestBloc(
    this._getCareersRequestUseCase,
    this._deleteCareerRequestUseCase,
    this._downloadResumeUseCase,
    this._fileOpenerUseCase,
    this._openExternalUrlUseCase,
  ) : super(
          const CareersRequestState(
            careerMap: {},
            downloadResumeFiles: [],
          ),
        ) {
    on<GetCareersRequestEvent>(_mapGetCareersRequestEventToState);
    on<DeleteCareersRequestEvent>(_mapDeleteCareersRequestEventToState);
    on<OpenResumeEvent>(_mapOpenResumeEventToState);
  }

  final GetCareersRequestUseCase _getCareersRequestUseCase;
  final DeleteCareerRequestUseCase _deleteCareerRequestUseCase;
  final DownloadResumeUseCase _downloadResumeUseCase;
  final FileOpenerUseCase _fileOpenerUseCase;
  final OpenExternalUrlUseCase _openExternalUrlUseCase;

  FutureOr<void> _mapGetCareersRequestEventToState(
    GetCareersRequestEvent event,
    Emitter<CareersRequestState> emit,
  ) async {
    final eitherResult = await _getCareersRequestUseCase();
    eitherResult.fold(
      (failure) => emit(state.copyWith(viewState: DSViewState.error)),
      (careers) {
        careers.sort((prev, next) {
          return next.uploadedAt.compareTo(prev.uploadedAt);
        });

        final careerDateMap = <String, List<CareerEntity>>{};
        for (final career in careers) {
          final key = career.uploadedAt.toMonthAndYear;
          if (!careerDateMap.containsKey(key)) {
            careerDateMap[key] = [];
          }
          careerDateMap[key]!.add(career);
        }

        emit(
          state.copyWith(
            careerMap: careerDateMap,
            viewState: DSViewState.idle,
          ),
        );
      },
    );
  }

  FutureOr<void> _mapDeleteCareersRequestEventToState(
    DeleteCareersRequestEvent event,
    Emitter<CareersRequestState> emit,
  ) async {
    final eitherResult = await _deleteCareerRequestUseCase(event.career);

    final deleteState = eitherResult.fold(
      (failure) => DeleteCareerFailureMessageState(event.career),
      (_) => DeleteCareerSuccessMessageState(event.career),
    );

    Map<String, List<CareerEntity>>? updatedCareerMap;
    if (deleteState is DeleteCareerSuccessMessageState) {
      final date = event.career.uploadedAt.toMonthAndYear;
      final careers = state.careerMap[date] ?? [];
      final updatedCareers = List<CareerEntity>.from(careers)
        ..remove(event.career);
      updatedCareerMap = Map<String, List<CareerEntity>>.from(state.careerMap);

      if (updatedCareers.isEmpty) {
        updatedCareerMap.remove(date);
      } else {
        updatedCareerMap[date] = updatedCareers;
      }
    }

    emit(
      state.copyWith(
        careerMap: updatedCareerMap,
        snackBarMessageState: deleteState,
      ),
    );
  }

  FutureOr<void> _mapOpenResumeEventToState(
    OpenResumeEvent event,
    Emitter<CareersRequestState> emit,
  ) async {
    emit(state.resetSnackBarMessage());

    if (kIsWeb) {
      final openUrlState = await _openResumeUrl(event.career.resumeUrl);
      emit(state.copyWith(snackBarMessageState: openUrlState));
      return;
    }

    final resumeFile = state.downloadResumeFiles.firstWhereOrNull((file) {
      return file.path.contains(event.career.resumeName);
    });

    if (resumeFile != null) {
      final downloadState = await _openFile(resumeFile);
      emit(state.copyWith(snackBarMessageState: downloadState));
      return;
    }

    final eitherResult = await _downloadResumeUseCase(event.career);
    if (eitherResult.isLeft) {
      emit(
        state.copyWith(
          snackBarMessageState: ResumeDownloadFailureMessageState(
            event.career,
          ),
        ),
      );
      return;
    }

    final file = eitherResult.right;
    final downloadState = await _openFile(file);
    List<File>? updatedFiles;
    if (downloadState is OpenFileSuccessMessageState) {
      updatedFiles = List<File>.from(state.downloadResumeFiles)..add(file);
    }
    emit(
      state.copyWith(
        snackBarMessageState: downloadState,
        downloadResumeFiles: updatedFiles,
      ),
    );
  }

  Future<SnackBarMessageState> _openResumeUrl(String resumeUrl) async {
    final eitherResult = await _openExternalUrlUseCase.execute(
      OpenExternalUrlParam(Uri.parse(resumeUrl), false),
    );
    return eitherResult.fold(
      (failure) => const OpenUrlFailureMessageState(),
      (isOpened) {
        if (isOpened) {
          return const OpenUrlSuccessMessageState();
        }
        return const OpenUrlFailureMessageState();
      },
    );
  }

  Future<SnackBarMessageState> _openFile(File file) async {
    final eitherResult = await _fileOpenerUseCase.execute(file);
    return eitherResult.fold(
      (failure) => OpenFileFailureMessageState(file),
      (_) => OpenFileSuccessMessageState(file),
    );
  }
}
