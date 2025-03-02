import 'package:design_system/design_system.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/src/feature/service/domain/domain.dart';
import 'package:wahl_analytics/src/feature/service/presentation/services_update/dto/dto.dart';
import 'package:wahl_analytics/src/feature/service/presentation/services_update/dto/servcie_update_form_field_type.dart';

class ServiceUpdateState extends Equatable {
  const ServiceUpdateState({
    required this.formKey,
    required this.textFieldControllers,
    required this.textFieldFocusNodes,
    this.viewState = DSViewState.idle,
    this.validationMessages = const {},
    this.isFormSubmittedSuccessfully = false,
    this.service,
    this.selectedIcon,
  });

  final DSViewState viewState;
  final GlobalKey<FormState> formKey;
  final Map<ServiceUpdateFormFieldType, TextEditingController>
      textFieldControllers;
  final Map<ServiceUpdateFormFieldType, FocusNode> textFieldFocusNodes;
  final Map<ServiceUpdateFormFieldType, FormFieldValidationMessage?>
      validationMessages;
  final bool isFormSubmittedSuccessfully;
  final ServiceEntity? service;
  final String? selectedIcon;

  @override
  List<Object?> get props => [
        viewState,
        validationMessages,
        isFormSubmittedSuccessfully,
        service,
        selectedIcon,
      ];

  ServiceUpdateState copyWith({
    DSViewState? viewState,
    Map<ServiceUpdateFormFieldType, FormFieldValidationMessage?>?
        validationMessages,
    bool? submissionSuccessful,
    ServiceEntity? service,
    String? selectedIcon,
  }) {
    return ServiceUpdateState(
      formKey: formKey,
      viewState: viewState ?? this.viewState,
      textFieldControllers: textFieldControllers,
      textFieldFocusNodes: textFieldFocusNodes,
      validationMessages: validationMessages ?? this.validationMessages,
      isFormSubmittedSuccessfully:
          submissionSuccessful ?? isFormSubmittedSuccessfully,
      service: service ?? this.service,
      selectedIcon: selectedIcon ?? this.selectedIcon,
    );
  }
}
