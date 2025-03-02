import 'package:design_system/design_system.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/src/feature/service/domain/domain.dart';
import 'package:wahl_analytics/src/feature/service/presentation/services_update/dto/dto.dart';

class ServicesUpdateState extends Equatable {
  const ServicesUpdateState({
    required this.formKey,
    required this.textFieldControllers,
    required this.textFieldFocusNodes,
    required this.locale,
    this.viewState = DSViewState.loading,
    this.validationMessages = const {},
    this.isFormSubmittedSuccessfully = false,
    this.isFormSubmitted = false,
    this.businessService,
    this.allLocaleBusinessServiceEntity,
  });

  final DSViewState viewState;
  final GlobalKey<FormState> formKey;
  final Map<ServicesUpdateFormFieldType, TextEditingController>
      textFieldControllers;
  final Map<ServicesUpdateFormFieldType, FocusNode> textFieldFocusNodes;
  final Map<ServicesUpdateFormFieldType, FormFieldValidationMessage?>
      validationMessages;
  final bool isFormSubmittedSuccessfully;
  final bool isFormSubmitted;
  final BusinessServiceEntity? businessService;
  final AllLocaleBusinessServiceEntity? allLocaleBusinessServiceEntity;
  final String locale;

  @override
  List<Object?> get props => [
        viewState,
        validationMessages,
        isFormSubmittedSuccessfully,
        isFormSubmitted,
        businessService,
        allLocaleBusinessServiceEntity,
        locale,
      ];

  ServicesUpdateState copyWith({
    DSViewState? viewState,
    Map<ServicesUpdateFormFieldType, FormFieldValidationMessage?>?
        validationMessages,
    bool? submissionSuccessful,
    bool? isFormSubmitted,
    BusinessServiceEntity? businessService,
    AllLocaleBusinessServiceEntity? allLocaleBusinessServiceEntity,
    String? locale,
  }) {
    return ServicesUpdateState(
      formKey: formKey,
      viewState: viewState ?? this.viewState,
      textFieldControllers: textFieldControllers,
      textFieldFocusNodes: textFieldFocusNodes,
      validationMessages: validationMessages ?? this.validationMessages,
      isFormSubmittedSuccessfully:
          submissionSuccessful ?? isFormSubmittedSuccessfully,
      isFormSubmitted: isFormSubmitted ?? this.isFormSubmitted,
      businessService: businessService ?? this.businessService,
      allLocaleBusinessServiceEntity:
          allLocaleBusinessServiceEntity ?? this.allLocaleBusinessServiceEntity,
      locale: locale ?? this.locale,
    );
  }
}
