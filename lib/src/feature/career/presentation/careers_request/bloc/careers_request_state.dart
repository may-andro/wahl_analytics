import 'dart:io';

import 'package:design_system/design_system.dart';
import 'package:equatable/equatable.dart';
import 'package:wahl_analytics/src/feature/career/domain/domain.dart';
import 'package:wahl_analytics/src/feature/career/presentation/careers_request/bloc/snack_bar_message_state.dart';

class CareersRequestState extends Equatable {
  const CareersRequestState({
    this.viewState = DSViewState.loading,
    required this.careerMap,
    required this.downloadResumeFiles,
    this.snackBarMessageState,
  });

  final DSViewState viewState;
  final Map<String, List<CareerEntity>> careerMap;
  final SnackBarMessageState? snackBarMessageState;
  final List<File> downloadResumeFiles;

  @override
  List<Object?> get props => [
    viewState,
    careerMap,
    snackBarMessageState,
    downloadResumeFiles,
  ];

  CareersRequestState copyWith({
    DSViewState? viewState,
    Map<String, List<CareerEntity>>? careerMap,
    SnackBarMessageState? snackBarMessageState,
    List<File>? downloadResumeFiles,
  }) {
    return CareersRequestState(
      viewState: viewState ?? this.viewState,
      careerMap: careerMap ?? this.careerMap,
      snackBarMessageState: snackBarMessageState ?? this.snackBarMessageState,
      downloadResumeFiles: downloadResumeFiles ?? this.downloadResumeFiles,
    );
  }

  CareersRequestState resetSnackBarMessage() {
    return CareersRequestState(
      viewState: viewState,
      careerMap: careerMap,
      downloadResumeFiles: downloadResumeFiles,
    );
  }
}
