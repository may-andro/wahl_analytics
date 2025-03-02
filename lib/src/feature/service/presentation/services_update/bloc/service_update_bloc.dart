import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wahl_analytics/src/feature/service/domain/domain.dart';
import 'package:wahl_analytics/src/feature/service/presentation/services_update/bloc/service_update_event.dart';
import 'package:wahl_analytics/src/feature/service/presentation/services_update/bloc/service_update_state.dart';
import 'package:wahl_analytics/src/feature/service/presentation/services_update/dto/dto.dart';
import 'package:wahl_analytics/src/feature/service/presentation/services_update/dto/servcie_update_form_field_type.dart';
import 'package:wahl_analytics/src/feature/validation/validation.dart';

class ServiceUpdateBloc extends Bloc<ServiceUpdateEvent, ServiceUpdateState> {
  ServiceUpdateBloc(
    this._isValidNameUseCase,
    this._isValidShortDescriptionUseCase,
    this._isValidLongDescriptionUseCase,
  ) : super(
          ServiceUpdateState(
            formKey: GlobalKey<FormState>(),
            textFieldFocusNodes: ServiceUpdateFormFieldType.focusNodeMap,
            textFieldControllers:
                ServiceUpdateFormFieldType.textEditingControllerMap,
          ),
        ) {
    on<OnInitServiceUpdateEvent>(_mapOnInitServiceUpdateEventToState);
    on<ValidateServiceUpdateTextFieldEvent>(
      _mapValidateServiceUpdateTextFieldEventToState,
    );
    on<SubmitServiceUpdateFormEvent>(_mapSubmitServiceUpdateFormEventToState);
    on<SelectServiceIconEvent>(_mapSelectServiceIconEventToState);
  }

  final IsValidNameUseCase _isValidNameUseCase;
  final IsValidShortDescriptionUseCase _isValidShortDescriptionUseCase;
  final IsValidLongDescriptionUseCase _isValidLongDescriptionUseCase;

  FutureOr<void> _mapOnInitServiceUpdateEventToState(
    OnInitServiceUpdateEvent event,
    Emitter<ServiceUpdateState> emit,
  ) async {
    if (event.service == null) {
      emit(
        state.copyWith(
          validationMessages: ServiceUpdateFormFieldType.validationMessageMap,
        ),
      );
      return;
    }

    final title = event.service?.title;
    final shortDescription = event.service?.shortDescription;
    final longDescription = event.service?.longDescription;

    state.textFieldControllers[ServiceUpdateFormFieldType.title]?.text =
        title ?? '';
    state.textFieldControllers[ServiceUpdateFormFieldType.shortDescription]
        ?.text = shortDescription ?? '';
    state.textFieldControllers[ServiceUpdateFormFieldType.longDescription]
        ?.text = longDescription ?? '';

    final validationMap =
        Map<ServiceUpdateFormFieldType, FormFieldValidationMessage?>.from(
      state.validationMessages,
    );
    validationMap[ServiceUpdateFormFieldType.title] =
        await _getTitleValidationMessage(title);

    validationMap[ServiceUpdateFormFieldType.shortDescription] =
        await _getShortDescriptionValidationMessage(shortDescription);

    validationMap[ServiceUpdateFormFieldType.longDescription] =
        await _getLongDescriptionValidationMessage(longDescription);

    emit(
      state.copyWith(
        service: event.service,
        selectedIcon: event.service?.icon,
        validationMessages: validationMap,
      ),
    );
  }

  FutureOr<void> _mapValidateServiceUpdateTextFieldEventToState(
    ValidateServiceUpdateTextFieldEvent event,
    Emitter<ServiceUpdateState> emit,
  ) async {
    FormFieldValidationMessage? message;

    switch (event.formFieldType) {
      case ServiceUpdateFormFieldType.title:
        message = await _getTitleValidationMessage(event.value);
      case ServiceUpdateFormFieldType.shortDescription:
        message = await _getShortDescriptionValidationMessage(event.value);
      case ServiceUpdateFormFieldType.longDescription:
        message = await _getLongDescriptionValidationMessage(event.value);
    }

    final validationMessages =
        Map<ServiceUpdateFormFieldType, FormFieldValidationMessage?>.from(
      state.validationMessages,
    )..[event.formFieldType] = message;

    emit(state.copyWith(validationMessages: validationMessages));
  }

  Future<FormFieldValidationMessage?> _getTitleValidationMessage(
    String? userTitle,
  ) async {
    FormFieldValidationMessage? message;

    final eitherResult = await _isValidNameUseCase(userTitle);
    eitherResult.fold(
      (failure) {
        switch (failure) {
          case InvalidNameFailure():
            message = FormFieldValidationMessage.invalidTitle;
          case EmptyNameFailure():
            message = FormFieldValidationMessage.noTitleFound;
          case NullNameFailure():
            message = FormFieldValidationMessage.invalidTitle;
        }
      },
      (isValid) {
        if (!isValid) {
          message = FormFieldValidationMessage.invalidTitle;
        }
      },
    );

    return message;
  }

  Future<FormFieldValidationMessage?> _getLongDescriptionValidationMessage(
    String? longDescription,
  ) async {
    FormFieldValidationMessage? message;

    final eitherResult = await _isValidLongDescriptionUseCase(longDescription);
    eitherResult.fold(
      (failure) {
        switch (failure) {
          case InvalidLongDescriptionFailure():
            message = FormFieldValidationMessage.invalidLongDescription;
          case EmptyLongDescriptionFailure():
            message = FormFieldValidationMessage.noLongDescriptionFound;
          case NullLongDescriptionFailure():
            message = FormFieldValidationMessage.invalidLongDescription;
        }
      },
      (isValid) {
        if (!isValid) {
          message = FormFieldValidationMessage.invalidLongDescription;
        }
      },
    );

    return message;
  }

  Future<FormFieldValidationMessage?> _getShortDescriptionValidationMessage(
    String? shortDescription,
  ) async {
    FormFieldValidationMessage? message;

    final eitherResult = await _isValidShortDescriptionUseCase(
      shortDescription,
    );
    eitherResult.fold(
      (failure) {
        switch (failure) {
          case InvalidShortDescriptionFailure():
            message = FormFieldValidationMessage.invalidShortDescription;
          case EmptyShortDescriptionFailure():
            message = FormFieldValidationMessage.noShortDescriptionFound;
          case NullShortDescriptionFailure():
            message = FormFieldValidationMessage.invalidShortDescription;
        }
      },
      (isValid) {
        if (!isValid) {
          message = FormFieldValidationMessage.invalidShortDescription;
        }
      },
    );

    return message;
  }

  FutureOr<void> _mapSubmitServiceUpdateFormEventToState(
    SubmitServiceUpdateFormEvent event,
    Emitter<ServiceUpdateState> emit,
  ) async {
    for (final focusNode in state.textFieldFocusNodes.values) {
      focusNode.unfocus();
    }

    final isFormValidate = state.formKey.currentState?.validate() ?? false;
    if (isFormValidate) {
      state.formKey.currentState?.save();

      final title =
          state.textFieldControllers[ServiceUpdateFormFieldType.title]?.text;
      final shortDescription = state
          .textFieldControllers[ServiceUpdateFormFieldType.shortDescription]
          ?.text;
      final longDescription = state
          .textFieldControllers[ServiceUpdateFormFieldType.longDescription]
          ?.text;
      final icon = state.selectedIcon!;

      emit(
        state.copyWith(
          submissionSuccessful: true,
          service: ServiceEntity(
            title: title!,
            shortDescription: shortDescription!,
            longDescription: longDescription!,
            icon: icon,
          ),
        ),
      );
    }
  }

  FutureOr<void> _mapSelectServiceIconEventToState(
    SelectServiceIconEvent event,
    Emitter<ServiceUpdateState> emit,
  ) async {
    emit(state.copyWith(selectedIcon: event.icon));
  }
}
