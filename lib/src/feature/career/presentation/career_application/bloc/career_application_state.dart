import 'package:design_system/design_system.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/src/feature/career/presentation/career_application/dto/dto.dart';
import 'package:wahl_analytics/src/feature/file_picker/file_picker.dart';

class CareerApplicationState extends Equatable {
  const CareerApplicationState({
    required this.formKey,
    required this.textFieldControllers,
    required this.textFieldFocusNodes,
    this.viewState = DSViewState.loading,
    this.validationMessages = const {},
    this.isConsentGiven = false,
    this.isFormSubmittedSuccessfully = false,
    this.resumeFile,
  });

  final DSViewState viewState;
  final GlobalKey<FormState> formKey;
  final Map<FormFieldType, TextEditingController> textFieldControllers;
  final Map<FormFieldType, FocusNode> textFieldFocusNodes;
  final Map<FormFieldType, FormFieldValidationMessage?> validationMessages;
  final bool isConsentGiven;
  final PickedFile? resumeFile;
  final bool isFormSubmittedSuccessfully;

  @override
  List<Object?> get props => [
    viewState,
    validationMessages,
    isConsentGiven,
    resumeFile,
    isFormSubmittedSuccessfully,
  ];

  CareerApplicationState copyWith({
    DSViewState? viewState,
    Map<FormFieldType, FormFieldValidationMessage?>? validationMessages,
    bool? isConsentGiven,
    PickedFile? resumeFile,
    bool? submissionSuccessful,
  }) {
    return CareerApplicationState(
      formKey: formKey,
      viewState: viewState ?? this.viewState,
      textFieldControllers: textFieldControllers,
      textFieldFocusNodes: textFieldFocusNodes,
      validationMessages: validationMessages ?? this.validationMessages,
      isConsentGiven: isConsentGiven ?? this.isConsentGiven,
      resumeFile: resumeFile ?? this.resumeFile,
      isFormSubmittedSuccessfully:
          submissionSuccessful ?? isFormSubmittedSuccessfully,
    );
  }
}
