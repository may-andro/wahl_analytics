import 'package:flutter/material.dart';
import 'package:wahl_analytics/src/feature/contact/presentation/contact_us/dto/form_field_validation_message.dart';

enum FormFieldType {
  name,
  email,
  message,
  consent;

  const FormFieldType();

  static Map<FormFieldType, TextEditingController>
      get textEditingControllerMap {
    return {
      FormFieldType.name: TextEditingController(),
      FormFieldType.email: TextEditingController(),
      FormFieldType.message: TextEditingController(),
    };
  }

  static Map<FormFieldType, FocusNode> get focusNodeMap {
    return {
      FormFieldType.name: FocusNode(),
      FormFieldType.email: FocusNode(),
      FormFieldType.message: FocusNode(),
    };
  }

  static Map<FormFieldType, FormFieldValidationMessage>
      get validationMessageMap {
    return {
      FormFieldType.name: FormFieldValidationMessage.noNameFound,
      FormFieldType.email: FormFieldValidationMessage.noEmailFound,
      FormFieldType.message: FormFieldValidationMessage.invalidMessage,
      FormFieldType.consent: FormFieldValidationMessage.missingConsent,
    };
  }
}
