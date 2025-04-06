import 'dart:async';

import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wahl_analytics/src/feature/career/domain/domain.dart';
import 'package:wahl_analytics/src/feature/career/presentation/career_application/bloc/career_application_event.dart';
import 'package:wahl_analytics/src/feature/career/presentation/career_application/bloc/career_application_state.dart';
import 'package:wahl_analytics/src/feature/career/presentation/career_application/dto/dto.dart';
import 'package:wahl_analytics/src/feature/file_picker/file_picker.dart';
import 'package:wahl_analytics/src/feature/validation/validation.dart';

class CareerApplicationBloc
    extends Bloc<CareerApplicationEvent, CareerApplicationState> {
  CareerApplicationBloc(
    this._buildConfig,
    this._isValidCountryUseCase,
    this._isValidEmailUseCase,
    this._isValidNameUseCase,
    this._isValidRoleUseCase,
    this._isValidMessageUseCase,
    this._filePickerUseCase,
    this._submitCareerApplicationUseCase,
  ) : super(
          CareerApplicationState(
            formKey: GlobalKey<FormState>(),
            textFieldFocusNodes: FormFieldType.focusNodeMap,
            textFieldControllers: FormFieldType.textEditingControllerMap,
          ),
        ) {
    on<InitialiseScreenEvent>(_mapInitialiseScreenEventToState);
    on<ValidateTextFieldEvent>(_mapValidateTextFieldEventToState);
    on<OnConsentSelectedEvent>(_mapOnConsentSelectedEventToState);
    on<UploadResumeEvent>(_mapUploadResumeEventToState);
    on<SubmitFormEvent>(_mapSubmitFormEventToState);
  }

  final BuildConfig _buildConfig;
  final IsValidCountryUseCase _isValidCountryUseCase;
  final IsValidEmailUseCase _isValidEmailUseCase;
  final IsValidNameUseCase _isValidNameUseCase;
  final IsValidRoleUseCase _isValidRoleUseCase;
  final IsValidMessageUseCase _isValidMessageUseCase;
  final FilePickerUseCase _filePickerUseCase;
  final SubmitCareerApplicationUseCase _submitCareerApplicationUseCase;

  FutureOr<void> _mapInitialiseScreenEventToState(
    InitialiseScreenEvent event,
    Emitter<CareerApplicationState> emit,
  ) {
    emit(
      state.copyWith(
        viewState: DSViewState.idle,
        validationMessages: FormFieldType.validationMessageMap,
      ),
    );
  }

  FutureOr<void> _mapSubmitFormEventToState(
    SubmitFormEvent event,
    Emitter<CareerApplicationState> emit,
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
      final role = _validateFieldAndEmitIfNeededBeforeSubmission(
        emit,
        FormFieldType.role,
        FormFieldValidationMessage.invalidRole,
      );
      final country = _validateFieldAndEmitIfNeededBeforeSubmission(
        emit,
        FormFieldType.country,
        FormFieldValidationMessage.invalidCountry,
      );
      final message = _validateFieldAndEmitIfNeededBeforeSubmission(
        emit,
        FormFieldType.message,
        FormFieldValidationMessage.invalidMessage,
      );
      final pickedFile = _validateResumeSubmission(emit);

      if (name.isNullOrEmpty ||
          email.isNullOrEmpty ||
          role.isNullOrEmpty ||
          country.isNullOrEmpty) {
        emit(state.copyWith(viewState: DSViewState.idle));
        return;
      }

      final careerEntity = CareerApplicationEntity(
        name: name!,
        email: email!,
        role: role!,
        country: country!,
        message: message ?? '',
        fileData: pickedFile!.bytes,
        env: _buildConfig.buildEnvironment.name,
      );
      final result = await _submitCareerApplicationUseCase(careerEntity);
      result.fold((left) {
        emit(state.copyWith(viewState: DSViewState.error));
      }, (right) {
        emit(
          state.copyWith(
            viewState: DSViewState.idle,
            submissionSuccessful: true,
          ),
        );
      });
    }
  }

  String? _validateFieldAndEmitIfNeededBeforeSubmission(
    Emitter<CareerApplicationState> emit,
    FormFieldType formFieldType,
    FormFieldValidationMessage formFieldValidationMessage,
  ) {
    final text = state.textFieldControllers[formFieldType]?.text;
    if (text.isNotNullOrEmpty) {
      return text;
    }

    final validationMessages =
        Map<FormFieldType, FormFieldValidationMessage?>.from(
      state.validationMessages,
    )..[formFieldType] = formFieldValidationMessage;
    emit(
      state.copyWith(
        validationMessages: validationMessages,
      ),
    );
    return null;
  }

  PickedFile? _validateResumeSubmission(Emitter<CareerApplicationState> emit) {
    if (state.resumeFile != null) {
      return state.resumeFile;
    }

    final validationMessages =
        Map<FormFieldType, FormFieldValidationMessage?>.from(
      state.validationMessages,
    )..[FormFieldType.resume] = FormFieldValidationMessage.fileUploadFailed;
    emit(state.copyWith(validationMessages: validationMessages));
    return null;
  }

  FutureOr<void> _mapOnConsentSelectedEventToState(
    OnConsentSelectedEvent event,
    Emitter<CareerApplicationState> emit,
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
    Emitter<CareerApplicationState> emit,
  ) async {
    FormFieldValidationMessage? message;

    switch (event.formFieldType) {
      case FormFieldType.name:
        message = await _getNameValidationMessage(event.value);
      case FormFieldType.email:
        message = await _getEmailValidationMessage(event.value);
      case FormFieldType.role:
        message = await _getRoleValidationMessage(event.value);
      case FormFieldType.country:
        message = await _getCountryValidationMessage(event.value);
      case FormFieldType.message:
        message = await _getMessageValidationMessage(event.value);
      case FormFieldType.consent:
      case FormFieldType.resume:
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

  Future<FormFieldValidationMessage?> _getRoleValidationMessage(
    String? role,
  ) async {
    FormFieldValidationMessage? message;

    final eitherResult = await _isValidRoleUseCase(role);
    eitherResult.fold(
      (failure) {
        switch (failure) {
          case InvalidRoleFailure():
            message = FormFieldValidationMessage.invalidRole;
          case EmptyRoleFailure():
            message = FormFieldValidationMessage.emptyRole;
          case NullRoleFailure():
            message = FormFieldValidationMessage.noRoleFound;
        }
      },
      (isValid) {
        if (!isValid) {
          message = FormFieldValidationMessage.invalidRole;
        }
      },
    );

    return message;
  }

  Future<FormFieldValidationMessage?> _getCountryValidationMessage(
    String? country,
  ) async {
    FormFieldValidationMessage? message;

    final eitherResult = await _isValidCountryUseCase(country);
    eitherResult.fold(
      (failure) {
        switch (failure) {
          case InvalidCountryFailure():
            message = FormFieldValidationMessage.invalidCountry;
          case EmptyCountryFailure():
            message = FormFieldValidationMessage.emptyCountry;
          case NullCountryFailure():
            message = FormFieldValidationMessage.noCountryFound;
        }
      },
      (isValid) {
        if (!isValid) {
          message = FormFieldValidationMessage.invalidCountry;
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
            message = null;
          case NullMessageFailure():
            message = null;
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

  FutureOr<void> _mapUploadResumeEventToState(
    UploadResumeEvent event,
    Emitter<CareerApplicationState> emit,
  ) async {
    final eitherResult = await _filePickerUseCase();

    eitherResult.fold(
      (failure) {
        FormFieldValidationMessage? message;
        switch (failure) {
          case FileNotFoundFailure():
            message = FormFieldValidationMessage.fileUploadFailed;
          case FileTooBigFailure():
            message = FormFieldValidationMessage.fileTooBig;
          case UnknownFilePickerFailure():
            message = FormFieldValidationMessage.fileUploadFailed;
        }
        final validationMessages =
            Map<FormFieldType, FormFieldValidationMessage?>.from(
          state.validationMessages,
        )..[FormFieldType.resume] = message;
        emit(state.copyWith(validationMessages: validationMessages));
      },
      (pickedFile) {
        emit(state.copyWith(resumeFile: pickedFile));
      },
    );
  }
}
