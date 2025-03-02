import 'package:flutter/material.dart';
import 'package:wahl_analytics/src/feature/service/presentation/services_update/dto/form_field_validation_message.dart';

enum ServiceUpdateFormFieldType {
  title,
  shortDescription,
  longDescription;

  const ServiceUpdateFormFieldType();

  static Map<ServiceUpdateFormFieldType, TextEditingController>
      get textEditingControllerMap {
    return {
      ServiceUpdateFormFieldType.title: TextEditingController(),
      ServiceUpdateFormFieldType.shortDescription: TextEditingController(),
      ServiceUpdateFormFieldType.longDescription: TextEditingController(),
    };
  }

  static Map<ServiceUpdateFormFieldType, FocusNode> get focusNodeMap {
    return {
      ServiceUpdateFormFieldType.title: FocusNode(),
      ServiceUpdateFormFieldType.shortDescription: FocusNode(),
      ServiceUpdateFormFieldType.longDescription: FocusNode(),
    };
  }

  static Map<ServiceUpdateFormFieldType, FormFieldValidationMessage>
      get validationMessageMap {
    return {
      ServiceUpdateFormFieldType.title: FormFieldValidationMessage.invalidTitle,
      ServiceUpdateFormFieldType.shortDescription:
          FormFieldValidationMessage.invalidShortDescription,
      ServiceUpdateFormFieldType.longDescription:
          FormFieldValidationMessage.invalidLongDescription,
    };
  }
}
