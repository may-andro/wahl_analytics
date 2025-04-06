import 'dart:io';

import 'package:design_system/design_system.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/l10n/l10n.dart';
import 'package:wahl_analytics/src/feature/career/domain/domain.dart';

sealed class SnackBarMessageState extends Equatable {
  const SnackBarMessageState();
}

final class OpenFileSuccessMessageState extends SnackBarMessageState {
  const OpenFileSuccessMessageState(this.file);

  final File file;

  @override
  List<Object?> get props => [file];
}

final class OpenFileFailureMessageState extends SnackBarMessageState {
  const OpenFileFailureMessageState(this.file);

  final File file;

  @override
  List<Object?> get props => [file];
}

final class ResumeDownloadFailureMessageState extends SnackBarMessageState {
  const ResumeDownloadFailureMessageState(this.careerEntity);

  final CareerEntity careerEntity;

  @override
  List<Object?> get props => [careerEntity];
}

final class OpenUrlSuccessMessageState extends SnackBarMessageState {
  const OpenUrlSuccessMessageState();

  @override
  List<Object?> get props => [];
}

final class OpenUrlFailureMessageState extends SnackBarMessageState {
  const OpenUrlFailureMessageState();

  @override
  List<Object?> get props => [];
}

final class DeleteCareerSuccessMessageState extends SnackBarMessageState {
  const DeleteCareerSuccessMessageState(this.careerEntity);

  final CareerEntity careerEntity;

  @override
  List<Object?> get props => [careerEntity];
}

final class DeleteCareerFailureMessageState extends SnackBarMessageState {
  const DeleteCareerFailureMessageState(this.careerEntity);

  final CareerEntity careerEntity;

  @override
  List<Object?> get props => [careerEntity];
}

extension SnackBarMessageStateExtension on SnackBarMessageState {
  SnackBar getSnackBar(BuildContext context) {
    return SnackBar(
      backgroundColor: _getBackgroundColor(context).color,
      content: DSTextWidget(
        _getMessage(context),
        style: context.typography.bodyLarge,
        color: _getTextColor(context),
      ),
    );
  }

  String _getMessage(BuildContext context) {
    final snackBarMessageState = this;
    return switch (snackBarMessageState) {
      OpenFileSuccessMessageState() =>
        context.localizations.resumeOpenMessage(snackBarMessageState.file.path),
      OpenUrlSuccessMessageState() =>
        context.localizations.resumeUrlOpenMessage,
      DeleteCareerSuccessMessageState() =>
        context.localizations.deleteCareerApplicationSuccess(
          snackBarMessageState.careerEntity.name,
        ),
      OpenFileFailureMessageState() =>
        context.localizations.resumeUrlOpenFailureMessage,
      ResumeDownloadFailureMessageState() => context.localizations
          .resumeDownloadFailureMessage(snackBarMessageState.careerEntity.name),
      OpenUrlFailureMessageState() =>
        context.localizations.resumeUrlOpenFailureMessage,
      DeleteCareerFailureMessageState() =>
        context.localizations.deleteCareerApplicationFailure(
          snackBarMessageState.careerEntity.name,
        ),
    };
  }

  DSColor _getBackgroundColor(BuildContext context) {
    final snackBarMessageState = this;
    return switch (snackBarMessageState) {
      OpenFileSuccessMessageState() => context.colorPalette.semantic.success,
      OpenUrlSuccessMessageState() => context.colorPalette.semantic.success,
      DeleteCareerSuccessMessageState() =>
        context.colorPalette.semantic.success,
      OpenFileFailureMessageState() => context.colorPalette.semantic.error,
      ResumeDownloadFailureMessageState() =>
        context.colorPalette.semantic.error,
      OpenUrlFailureMessageState() => context.colorPalette.semantic.error,
      DeleteCareerFailureMessageState() => context.colorPalette.semantic.error,
    };
  }

  DSColor _getTextColor(BuildContext context) {
    final snackBarMessageState = this;
    return switch (snackBarMessageState) {
      OpenFileSuccessMessageState() => context.colorPalette.semantic.onSuccess,
      OpenUrlSuccessMessageState() => context.colorPalette.semantic.onSuccess,
      DeleteCareerSuccessMessageState() =>
        context.colorPalette.semantic.onError,
      OpenFileFailureMessageState() => context.colorPalette.semantic.onError,
      ResumeDownloadFailureMessageState() =>
        context.colorPalette.semantic.onError,
      OpenUrlFailureMessageState() => context.colorPalette.semantic.onError,
      DeleteCareerFailureMessageState() =>
        context.colorPalette.semantic.onError,
    };
  }
}
