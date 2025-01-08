import 'package:design_system/design_system.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/src/feature/contact/contact.dart';
import 'package:wahl_analytics/src/feature/contact/presentation/contact_us/dto/dto.dart';

class ContactUsState extends Equatable {
  const ContactUsState({
    required this.formKey,
    required this.textFieldControllers,
    required this.textFieldFocusNodes,
    this.viewState = DSViewState.loading,
    this.validationMessages = const {},
    this.isConsentGiven = false,
    this.isFormSubmittedSuccessfully = false,
    this.businessContact,
  });

  final GlobalKey<FormState> formKey;
  final Map<FormFieldType, TextEditingController> textFieldControllers;
  final Map<FormFieldType, FocusNode> textFieldFocusNodes;
  final DSViewState viewState;
  final Map<FormFieldType, FormFieldValidationMessage?> validationMessages;
  final bool isConsentGiven;
  final bool isFormSubmittedSuccessfully;
  final BusinessContactEntity? businessContact;

  @override
  List<Object?> get props => [
        viewState,
        validationMessages,
        isConsentGiven,
        isFormSubmittedSuccessfully,
        businessContact,
      ];

  ContactUsState copyWith({
    DSViewState? viewState,
    Map<FormFieldType, FormFieldValidationMessage?>? validationMessages,
    bool? isConsentGiven,
    bool? submissionSuccessful,
    BusinessContactEntity? businessContact,
  }) {
    return ContactUsState(
      formKey: formKey,
      viewState: viewState ?? this.viewState,
      textFieldControllers: textFieldControllers,
      textFieldFocusNodes: textFieldFocusNodes,
      validationMessages: validationMessages ?? this.validationMessages,
      isConsentGiven: isConsentGiven ?? this.isConsentGiven,
      isFormSubmittedSuccessfully:
          submissionSuccessful ?? isFormSubmittedSuccessfully,
      businessContact: businessContact ?? this.businessContact,
    );
  }
}
