import 'package:flutter/material.dart';
import 'package:wahl_analytics/src/feature/service/presentation/services_update/dto/form_field_validation_message.dart';

enum ServicesUpdateFormFieldType {
  title,
  description;

  const ServicesUpdateFormFieldType();

  static Map<ServicesUpdateFormFieldType, TextEditingController>
      get textEditingControllerMap {
    return {
      ServicesUpdateFormFieldType.title: TextEditingController(),
      ServicesUpdateFormFieldType.description: TextEditingController(),
    };
  }

  static Map<ServicesUpdateFormFieldType, FocusNode> get focusNodeMap {
    return {
      ServicesUpdateFormFieldType.title: FocusNode(),
      ServicesUpdateFormFieldType.description: FocusNode(),
    };
  }

  static Map<ServicesUpdateFormFieldType, FormFieldValidationMessage>
      get validationMessageMap {
    return {
      ServicesUpdateFormFieldType.title:
          FormFieldValidationMessage.invalidTitle,
      ServicesUpdateFormFieldType.description:
          FormFieldValidationMessage.invalidDescription,
    };
  }
}
