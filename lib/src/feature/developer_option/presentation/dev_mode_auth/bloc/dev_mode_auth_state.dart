import 'package:design_system/design_system.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/src/feature/developer_option/presentation/dev_mode_auth/dto/dto.dart';

class DevModeAuthState extends Equatable {
  const DevModeAuthState({
    required this.formKey,
    required this.textFieldController,
    required this.focusNode,
    this.verificationDocId,
    this.validationMessage = FormFieldValidationMessage.emptyCode,
    this.viewState = DSViewState.loading,
    this.isAuthenticatedSuccessfully = false,
  });

  final DSViewState viewState;
  final GlobalKey<FormState> formKey;
  final TextEditingController textFieldController;
  final FocusNode focusNode;
  final FormFieldValidationMessage validationMessage;
  final String? verificationDocId;
  final bool isAuthenticatedSuccessfully;

  @override
  List<Object?> get props => [
        formKey,
        textFieldController,
        focusNode,
        validationMessage,
        verificationDocId,
        viewState,
        isAuthenticatedSuccessfully,
      ];

  DevModeAuthState copyWith({
    DSViewState? viewState,
    FormFieldValidationMessage? validationMessage,
    String? verificationDocId,
    bool? isAuthenticatedSuccessfully,
  }) {
    return DevModeAuthState(
      formKey: formKey,
      textFieldController: textFieldController,
      focusNode: focusNode,
      viewState: viewState ?? this.viewState,
      validationMessage: validationMessage ?? this.validationMessage,
      verificationDocId: verificationDocId ?? this.verificationDocId,
      isAuthenticatedSuccessfully:
          isAuthenticatedSuccessfully ?? this.isAuthenticatedSuccessfully,
    );
  }
}
