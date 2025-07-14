import 'dart:async';

import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wahl_analytics/src/feature/developer_option/domain/domain.dart';
import 'package:wahl_analytics/src/feature/developer_option/presentation/dev_mode_auth/bloc/dev_mode_auth_event.dart';
import 'package:wahl_analytics/src/feature/developer_option/presentation/dev_mode_auth/bloc/dev_mode_auth_state.dart';
import 'package:wahl_analytics/src/feature/developer_option/presentation/dev_mode_auth/dto/dto.dart';
import 'package:wahl_analytics/src/feature/validation/validation.dart';

class DevModeAuthBloc extends Bloc<DevModeAuthEvent, DevModeAuthState> {
  DevModeAuthBloc(
    this._requestVerificationCodeUseCase,
    this._submitVerificationCodeUseCase,
    this._cacheDevModeAuthenticationUseCase,
    this._isValidVerificationCodeUseCase,
  ) : super(
        DevModeAuthState(
          formKey: GlobalKey<FormState>(),
          textFieldController: TextEditingController(),
          focusNode: FocusNode()..requestFocus(),
        ),
      ) {
    on<OnInitEvent>(_mapOnInitEventToState);
    on<ValidateTextFieldEvent>(_mapValidateTextFieldEventToState);
    on<SubmitFormEvent>(_mapSubmitFormEventToState);
  }

  final RequestVerificationCodeUseCase _requestVerificationCodeUseCase;
  final SubmitVerificationCodeUseCase _submitVerificationCodeUseCase;
  final CacheDevModeAuthenticationUseCase _cacheDevModeAuthenticationUseCase;
  final IsValidVerificationCodeUseCase _isValidVerificationCodeUseCase;

  FutureOr<void> _mapOnInitEventToState(
    OnInitEvent event,
    Emitter<DevModeAuthState> emit,
  ) async {
    final eitherResult = await _requestVerificationCodeUseCase();
    eitherResult.fold(
      (failure) {
        emit(state.copyWith(viewState: DSViewState.error));
      },
      (docId) {
        emit(
          state.copyWith(viewState: DSViewState.idle, verificationDocId: docId),
        );
      },
    );
  }

  FutureOr<void> _mapValidateTextFieldEventToState(
    ValidateTextFieldEvent event,
    Emitter<DevModeAuthState> emit,
  ) async {
    final eitherResult = await _isValidVerificationCodeUseCase(
      event.text?.trim(),
    );
    final message = eitherResult.fold(
      (failure) {
        switch (failure) {
          case InvalidVerificationCodeFailure _:
            return FormFieldValidationMessage.invalidCode;
          case EmptyVerificationCodeFailure _:
            return FormFieldValidationMessage.emptyCode;
          case NullVerificationCodeFailure _:
            return FormFieldValidationMessage.noCodeFound;
        }
      },
      (isValid) {
        return isValid
            ? FormFieldValidationMessage.none
            : FormFieldValidationMessage.invalidCode;
      },
    );
    emit(state.copyWith(validationMessage: message));
  }

  FutureOr<void> _mapSubmitFormEventToState(
    SubmitFormEvent event,
    Emitter<DevModeAuthState> emit,
  ) async {
    state.focusNode.unfocus();

    final isFormValidate = state.formKey.currentState?.validate() ?? false;
    if (!isFormValidate) {
      return;
    }

    state.formKey.currentState?.save();

    final eitherResult = await _submitVerificationCodeUseCase(
      SubmitVerificationCodeParam(docId: event.docId, code: event.code),
    );

    final newState = eitherResult.fold(
      (failure) {
        state.textFieldController.text = '';
        switch (failure) {
          case ExpiredCodeFailure _:
            return state.copyWith(
              validationMessage: FormFieldValidationMessage.codeExpired,
            );
          case UnknownSubmissionFailure _:
            return state.copyWith(
              validationMessage: FormFieldValidationMessage.unknown,
            );
        }
      },
      (isAuthenticated) {
        _cacheDevModeAuthenticationUseCase(isAuthenticated);
        if (isAuthenticated) {
          return state.copyWith(isAuthenticatedSuccessfully: true);
        } else {
          state.textFieldController.text = '';
          return state.copyWith(
            validationMessage: FormFieldValidationMessage.invalidCode,
          );
        }
      },
    );

    emit(newState);
  }
}

extension DevModeAuthBuildContextExtension on BuildContext {
  DevModeAuthBloc get bloc => read<DevModeAuthBloc>();

  DevModeAuthState get state => bloc.state;
}
