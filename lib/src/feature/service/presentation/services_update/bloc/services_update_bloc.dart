import 'dart:async';

import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wahl_analytics/src/feature/service/domain/domain.dart';
import 'package:wahl_analytics/src/feature/service/presentation/services_update/bloc/services_update_event.dart';
import 'package:wahl_analytics/src/feature/service/presentation/services_update/bloc/services_update_state.dart';
import 'package:wahl_analytics/src/feature/service/presentation/services_update/dto/dto.dart';
import 'package:wahl_analytics/src/feature/validation/validation.dart';

class ServicesUpdateBloc
    extends Bloc<ServicesUpdateEvent, ServicesUpdateState> {
  ServicesUpdateBloc(
    AppLocale appLocale,
    this._getAllLocaleBusinessServiceUseCase,
    this._updateAllLocaleBusinessServiceUseCase,
    this._isValidNameUseCase,
    this._isValidMessageUseCase,
  ) : super(
          ServicesUpdateState(
            formKey: GlobalKey<FormState>(),
            textFieldFocusNodes: ServicesUpdateFormFieldType.focusNodeMap,
            textFieldControllers:
                ServicesUpdateFormFieldType.textEditingControllerMap,
            locale: appLocale.locale,
          ),
        ) {
    on<GetBusinessServiceEvent>(_mapOnGetBusinessServiceEventToState);
    on<ValidateTextFieldEvent>(_mapValidateTextFieldEventToState);
    on<SubmitFormEvent>(_mapSubmitFormEventToState);
    on<AddServiceFormEvent>(_mapAddServiceFormEventToState);
    on<UpdateServiceFormEvent>(_mapUpdateServiceFormEventToState);
    on<DeleteServiceFormEvent>(_mapDeleteServiceFormEventToState);
    on<SelectLocaleEvent>(_mapSelectLocaleEventToState);
    on<ReorderServicePositionEvent>(_mapReorderServicePositionEventToState);
  }

  final GetAllLocaleBusinessServiceUseCase _getAllLocaleBusinessServiceUseCase;
  final UpdateAllLocaleBusinessServiceUseCase
      _updateAllLocaleBusinessServiceUseCase;
  final IsValidNameUseCase _isValidNameUseCase;
  final IsValidMessageUseCase _isValidMessageUseCase;

  FutureOr<void> _mapOnGetBusinessServiceEventToState(
    GetBusinessServiceEvent event,
    Emitter<ServicesUpdateState> emit,
  ) async {
    final businessServiceEither = await _getAllLocaleBusinessServiceUseCase();
    businessServiceEither.fold(
      (failure) => emit(state.copyWith(viewState: DSViewState.error)),
      (allLocaleBusinessService) {
        final businessService = _getBusinessService(
          state.locale,
          allLocaleBusinessService,
        );

        state.textFieldControllers[ServicesUpdateFormFieldType.title]?.text =
            businessService.title;
        state.textFieldControllers[ServicesUpdateFormFieldType.description]
            ?.text = businessService.description;
        emit(
          state.copyWith(
            viewState: DSViewState.idle,
            businessService: businessService,
            allLocaleBusinessServiceEntity: allLocaleBusinessService,
          ),
        );
      },
    );
  }

  FutureOr<void> _mapValidateTextFieldEventToState(
    ValidateTextFieldEvent event,
    Emitter<ServicesUpdateState> emit,
  ) async {
    FormFieldValidationMessage? message;

    switch (event.formFieldType) {
      case ServicesUpdateFormFieldType.title:
        message = await _getTitleValidationMessage(event.value);
      case ServicesUpdateFormFieldType.description:
        message = await _getDescriptionValidationMessage(event.value);
    }

    final validationMessages =
        Map<ServicesUpdateFormFieldType, FormFieldValidationMessage?>.from(
      state.validationMessages,
    )..[event.formFieldType] = message;

    emit(state.copyWith(validationMessages: validationMessages));
  }

  Future<FormFieldValidationMessage?> _getTitleValidationMessage(
    String? userMessage,
  ) async {
    FormFieldValidationMessage? message;

    final eitherResult = await _isValidNameUseCase(userMessage);
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

  Future<FormFieldValidationMessage?> _getDescriptionValidationMessage(
    String? userMessage,
  ) async {
    FormFieldValidationMessage? message;

    final eitherResult = await _isValidMessageUseCase(userMessage);
    eitherResult.fold(
      (failure) {
        switch (failure) {
          case InvalidMessageFailure():
            message = FormFieldValidationMessage.invalidDescription;
          case EmptyMessageFailure():
            message = FormFieldValidationMessage.noDescriptionFound;
          case NullMessageFailure():
            message = FormFieldValidationMessage.invalidDescription;
        }
      },
      (isValid) {
        if (!isValid) {
          message = FormFieldValidationMessage.invalidDescription;
        }
      },
    );

    return message;
  }

  FutureOr<void> _mapSubmitFormEventToState(
    SubmitFormEvent event,
    Emitter<ServicesUpdateState> emit,
  ) async {
    for (final focusNode in state.textFieldFocusNodes.values) {
      focusNode.unfocus();
    }

    final isFormValidate = state.formKey.currentState?.validate() ?? false;
    if (isFormValidate) {
      state.formKey.currentState?.save();
      emit(state.copyWith(isFormSubmitted: true));

      final title =
          state.textFieldControllers[ServicesUpdateFormFieldType.title]?.text;
      final description = state
          .textFieldControllers[ServicesUpdateFormFieldType.description]?.text;
      final businessService = state.businessService?.copyWith(
        title: title,
        description: description,
      );

      if (businessService == null) {
        emit(
          state.copyWith(
            isFormSubmitted: false,
            submissionSuccessful: false,
          ),
        );
        return;
      }

      final allLocaleBusinessServiceEntity = _getAllLocaleBusinessServiceEntity(
        state.locale,
        businessService,
      );

      final result = await _updateAllLocaleBusinessServiceUseCase(
        allLocaleBusinessServiceEntity!,
      );

      result.fold(
        (failure) {
          state.copyWith(
            isFormSubmitted: false,
            businessService: businessService,
            submissionSuccessful: false,
          );
        },
        (success) {
          emit(
            state.copyWith(
              isFormSubmitted: false,
              businessService: businessService,
              submissionSuccessful: true,
            ),
          );
        },
      );
    }
  }

  FutureOr<void> _mapAddServiceFormEventToState(
    AddServiceFormEvent event,
    Emitter<ServicesUpdateState> emit,
  ) {
    final services = state.businessService?.services ?? [];
    final updatedServices = List<ServiceEntity>.from(services)
      ..add(event.service);
    final businessService = state.businessService?.copyWith(
      services: updatedServices,
    );
    emit(
      state.copyWith(
        businessService: businessService,
        allLocaleBusinessServiceEntity: _getAllLocaleBusinessServiceEntity(
          state.locale,
          businessService,
        ),
      ),
    );
  }

  FutureOr<void> _mapUpdateServiceFormEventToState(
    UpdateServiceFormEvent event,
    Emitter<ServicesUpdateState> emit,
  ) {
    final services = state.businessService?.services ?? [];
    final updatedServices = List<ServiceEntity>.from(services)
      ..[event.index] = (event.service);
    final businessService = state.businessService?.copyWith(
      services: updatedServices,
    );
    emit(
      state.copyWith(
        businessService: businessService,
        allLocaleBusinessServiceEntity: _getAllLocaleBusinessServiceEntity(
          state.locale,
          businessService,
        ),
      ),
    );
  }

  FutureOr<void> _mapDeleteServiceFormEventToState(
    DeleteServiceFormEvent event,
    Emitter<ServicesUpdateState> emit,
  ) {
    final services = state.businessService?.services ?? [];
    final updatedServices = List<ServiceEntity>.from(services)
      ..remove(event.service);
    final businessService = state.businessService?.copyWith(
      services: updatedServices,
    );

    emit(
      state.copyWith(
        businessService: businessService,
        allLocaleBusinessServiceEntity: _getAllLocaleBusinessServiceEntity(
          state.locale,
          businessService,
        ),
      ),
    );
  }

  FutureOr<void> _mapSelectLocaleEventToState(
    SelectLocaleEvent event,
    Emitter<ServicesUpdateState> emit,
  ) {
    var businessService = state.businessService;
    businessService = businessService?.copyWith(
      title:
          state.textFieldControllers[ServicesUpdateFormFieldType.title]?.text,
      description: state
          .textFieldControllers[ServicesUpdateFormFieldType.description]?.text,
    );
    final updatedAllLocaleBusinessService = _getAllLocaleBusinessServiceEntity(
      state.locale,
      businessService,
    );

    if (updatedAllLocaleBusinessService != null) {
      final businessService = _getBusinessService(
        event.locale,
        updatedAllLocaleBusinessService,
      );
      state.textFieldControllers[ServicesUpdateFormFieldType.title]?.text =
          businessService.title;
      state.textFieldControllers[ServicesUpdateFormFieldType.description]
          ?.text = businessService.description;

      emit(
        state.copyWith(
          locale: event.locale,
          businessService: businessService,
          allLocaleBusinessServiceEntity: updatedAllLocaleBusinessService,
        ),
      );
    }
  }

  BusinessServiceEntity _getBusinessService(
    String locale,
    AllLocaleBusinessServiceEntity allLocaleBusinessService,
  ) {
    switch (locale) {
      case 'es':
        return allLocaleBusinessService.es;
      case 'nl':
        return allLocaleBusinessService.nl;
      default:
        return allLocaleBusinessService.en;
    }
  }

  AllLocaleBusinessServiceEntity? _getAllLocaleBusinessServiceEntity(
    String locale,
    BusinessServiceEntity? businessService,
  ) {
    var allLocaleBusinessService = state.allLocaleBusinessServiceEntity;
    switch (locale) {
      case 'es':
        allLocaleBusinessService = allLocaleBusinessService?.copyWith(
          es: businessService,
        );
      case 'nl':
        allLocaleBusinessService = allLocaleBusinessService?.copyWith(
          nl: businessService,
        );
      default:
        allLocaleBusinessService = allLocaleBusinessService?.copyWith(
          en: businessService,
        );
    }
    return allLocaleBusinessService;
  }

  FutureOr<void> _mapReorderServicePositionEventToState(
    ReorderServicePositionEvent event,
    Emitter<ServicesUpdateState> emit,
  ) {
    final services = state.businessService?.services ?? [];
    final updatedServices = List<ServiceEntity>.from(services);
    final service = updatedServices.removeAt(event.oldIndex);
    updatedServices.insert(event.newIndex, service);
    final businessService = state.businessService?.copyWith(
      services: updatedServices,
    );

    emit(
      state.copyWith(
        businessService: businessService,
        allLocaleBusinessServiceEntity: _getAllLocaleBusinessServiceEntity(
          state.locale,
          businessService,
        ),
      ),
    );
  }
}
