import 'package:flutter/material.dart';
import 'package:wahl_analytics/src/feature/career/presentation/dto/form_field_validation_message.dart';

enum FormFieldType {
  name,
  email,
  role,
  country,
  message,
  resume,
  consent;

  const FormFieldType();

  static Map<FormFieldType, TextEditingController>
      get textEditingControllerMap {
    return {
      FormFieldType.name: TextEditingController(),
      FormFieldType.role: TextEditingController(),
      FormFieldType.email: TextEditingController(),
      FormFieldType.country: TextEditingController(),
      FormFieldType.message: TextEditingController(),
    };
  }

  static Map<FormFieldType, FocusNode> get focusNodeMap {
    return {
      FormFieldType.name: FocusNode(),
      FormFieldType.role: FocusNode(),
      FormFieldType.email: FocusNode(),
      FormFieldType.country: FocusNode(),
      FormFieldType.message: FocusNode(),
    };
  }

  static Map<FormFieldType, FormFieldValidationMessage>
      get validationMessageMap {
    return {
      FormFieldType.name: FormFieldValidationMessage.noNameFound,
      FormFieldType.role: FormFieldValidationMessage.noRoleFound,
      FormFieldType.email: FormFieldValidationMessage.noEmailFound,
      FormFieldType.country: FormFieldValidationMessage.noCountryFound,
      FormFieldType.resume: FormFieldValidationMessage.uploadFile,
      FormFieldType.consent: FormFieldValidationMessage.missingConsent,
    };
  }
}
