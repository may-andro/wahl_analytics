import 'dart:async';

import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:feature_flag/feature_flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wahl_analytics/src/feature/contact/domain/domain.dart';
import 'package:wahl_analytics/src/feature/contact/presentation/contact_us/bloc/contact_us_event.dart';
import 'package:wahl_analytics/src/feature/contact/presentation/contact_us/bloc/contact_us_state.dart';
import 'package:wahl_analytics/src/feature/contact/presentation/contact_us/dto/dto.dart';
import 'package:wahl_analytics/src/feature/contact/presentation/contact_us/tracking/tracking.dart';
import 'package:wahl_analytics/src/feature/validation/validation.dart';

class ContactUsBloc extends Bloc<ContactUsEvent, ContactUsState> {
  ContactUsBloc(
    this._isValidEmailUseCase,
    this._isValidNameUseCase,
    this._isValidMessageUseCase,
    this._isFeatureEnabledUseCase,
    this._getBusinessContactUseCase,
    this._submitContactUsApplicationUseCase,
    this._trackingDelegate,
  ) : super(
        ContactUsState(
          formKey: GlobalKey<FormState>(),
          textFieldFocusNodes: FormFieldType.focusNodeMap,
          textFieldControllers: FormFieldType.textEditingControllerMap,
        ),
      ) {
    on<OnInitEvent>(_mapOnInitEventToState);
    on<OnScreenVisibleEvent>(_mapOnScreenVisibleEventToState);
    on<ValidateTextFieldEvent>(_mapValidateTextFieldEventToState);
    on<OnConsentSelectedEvent>(_mapOnConsentSelectedEventToState);
    on<SubmitFormEvent>(_mapSubmitFormEventToState);
    on<OnCloseClickEvent>(_mapOnCloseClickEventToState);
  }

  final IsValidEmailUseCase _isValidEmailUseCase;
  final IsValidNameUseCase _isValidNameUseCase;
  final IsValidMessageUseCase _isValidMessageUseCase;
  final IsFeatureEnabledUseCase _isFeatureEnabledUseCase;
  final GetBusinessContactUseCase _getBusinessContactUseCase;
  final SubmitContactUsApplicationUseCase _submitContactUsApplicationUseCase;
  final ContactUsTrackingDelegate _trackingDelegate;

  Future<bool> get isMobileDetailVisible async {
    final eitherResult = await _isFeatureEnabledUseCase(
      Feature.mobileDetailVisibility,
    );
    return eitherResult.fold((_) => false, (isEnabled) => isEnabled);
  }

  FutureOr<void> _mapOnInitEventToState(
    OnInitEvent event,
    Emitter<ContactUsState> emit,
  ) async {
    emit(
      state.copyWith(
        viewState: DSViewState.loading,
        validationMessages: FormFieldType.validationMessageMap,
      ),
    );
    final businessContactEither = await _getBusinessContactUseCase();
    businessContactEither.fold(
      (failure) {
        emit(state.copyWith(viewState: DSViewState.idle));
      },
      (businessContact) {
        emit(
          state.copyWith(
            viewState: DSViewState.idle,
            businessContact: businessContact,
          ),
        );
      },
    );
  }

  FutureOr<void> _mapOnScreenVisibleEventToState(
    OnScreenVisibleEvent event,
    Emitter<ContactUsState> emit,
  ) {
    _trackingDelegate.trackScreenView();
  }

  FutureOr<void> _mapSubmitFormEventToState(
    SubmitFormEvent event,
    Emitter<ContactUsState> emit,
  ) async {
    for (final focusNode in state.textFieldFocusNodes.values) {
      focusNode.unfocus();
    }

    final isFormValidate = state.formKey.currentState?.validate() ?? false;
    if (isFormValidate) {
      state.formKey.currentState?.save();
      emit(state.copyWith(viewState: DSViewState.loading));

      final name = _validateFieldAndEmitIfNeededBeforeSubmission(
        emit,
        FormFieldType.name,
        FormFieldValidationMessage.invalidName,
      );
      final email = _validateFieldAndEmitIfNeededBeforeSubmission(
        emit,
        FormFieldType.email,
        FormFieldValidationMessage.invalidEmail,
      );
      final message = _validateFieldAndEmitIfNeededBeforeSubmission(
        emit,
        FormFieldType.message,
        FormFieldValidationMessage.invalidMessage,
      );

      if (name.isNullOrEmpty || email.isNullOrEmpty || message.isNullOrEmpty) {
        return;
      }

      final contactUsEntity = ContactUsEntity(
        name: name!,
        email: email!,
        message: message!,
      );
      final result = await _submitContactUsApplicationUseCase(contactUsEntity);
      result.fold(
        (left) {
          _trackingDelegate.trackSubmitFormFailure();
          emit(state.copyWith(viewState: DSViewState.error));
        },
        (right) {
          _trackingDelegate.trackSubmitForm();
          emit(
            state.copyWith(
              viewState: DSViewState.idle,
              submissionSuccessful: true,
            ),
          );
        },
      );
    }
  }

  String? _validateFieldAndEmitIfNeededBeforeSubmission(
    Emitter<ContactUsState> emit,
    FormFieldType formFieldType,
    FormFieldValidationMessage message,
  ) {
    final text = state.textFieldControllers[formFieldType]?.text;
    if (text.isNotNullOrEmpty) {
      return text;
    }

    final validationMessages =
        Map<FormFieldType, FormFieldValidationMessage?>.from(
          state.validationMessages,
        )..[formFieldType] = message;
    emit(state.copyWith(validationMessages: validationMessages));
    return null;
  }

  FutureOr<void> _mapOnConsentSelectedEventToState(
    OnConsentSelectedEvent event,
    Emitter<ContactUsState> emit,
  ) {
    FormFieldValidationMessage? message;
    if (!event.isConsentGiven) {
      message = FormFieldValidationMessage.missingConsent;
    }
    final validationMessages =
        Map<FormFieldType, FormFieldValidationMessage?>.from(
          state.validationMessages,
        )..[FormFieldType.consent] = message;
    emit(
      state.copyWith(
        isConsentGiven: event.isConsentGiven,
        validationMessages: validationMessages,
      ),
    );
  }

  FutureOr<void> _mapValidateTextFieldEventToState(
    ValidateTextFieldEvent event,
    Emitter<ContactUsState> emit,
  ) async {
    FormFieldValidationMessage? message;

    switch (event.formFieldType) {
      case FormFieldType.name:
        message = await _getNameValidationMessage(event.value);
      case FormFieldType.email:
        message = await _getEmailValidationMessage(event.value);
      case FormFieldType.message:
        message = await _getMessageValidationMessage(event.value);
      case FormFieldType.consent:
        break;
    }

    final validationMessages =
        Map<FormFieldType, FormFieldValidationMessage?>.from(
          state.validationMessages,
        )..[event.formFieldType] = message;

    emit(state.copyWith(validationMessages: validationMessages));
  }

  Future<FormFieldValidationMessage?> _getNameValidationMessage(
    String? name,
  ) async {
    final eitherResult = await _isValidNameUseCase(name);
    FormFieldValidationMessage? message;

    eitherResult.fold(
      (failure) {
        switch (failure) {
          case InvalidNameFailure():
            message = FormFieldValidationMessage.invalidName;
          case EmptyNameFailure():
            message = FormFieldValidationMessage.emptyName;
          case NullNameFailure():
            message = FormFieldValidationMessage.noNameFound;
        }
      },
      (isValid) {
        if (!isValid) {
          message = FormFieldValidationMessage.invalidName;
        }
      },
    );

    return message;
  }

  Future<FormFieldValidationMessage?> _getEmailValidationMessage(
    String? email,
  ) async {
    FormFieldValidationMessage? message;

    final eitherResult = await _isValidEmailUseCase(email);
    eitherResult.fold(
      (failure) {
        switch (failure) {
          case InvalidEmailFailure():
            message = FormFieldValidationMessage.invalidEmail;
          case EmptyEmailFailure():
            message = FormFieldValidationMessage.emptyEmail;
          case NullEmailFailure():
            message = FormFieldValidationMessage.noEmailFound;
        }
      },
      (isValid) {
        if (!isValid) {
          message = FormFieldValidationMessage.invalidEmail;
        }
      },
    );

    return message;
  }

  Future<FormFieldValidationMessage?> _getMessageValidationMessage(
    String? userMessage,
  ) async {
    FormFieldValidationMessage? message;

    final eitherResult = await _isValidMessageUseCase(userMessage);
    eitherResult.fold(
      (failure) {
        switch (failure) {
          case InvalidMessageFailure():
            message = FormFieldValidationMessage.invalidMessage;
          case EmptyMessageFailure():
            message = FormFieldValidationMessage.invalidMessage;
          case NullMessageFailure():
            message = FormFieldValidationMessage.invalidMessage;
        }
      },
      (isValid) {
        if (!isValid) {
          message = FormFieldValidationMessage.invalidMessage;
        }
      },
    );

    return message;
  }

  FutureOr<void> _mapOnCloseClickEventToState(
    OnCloseClickEvent event,
    Emitter<ContactUsState> emit,
  ) {
    _trackingDelegate.trackAppBarCloseClick();
  }
}
