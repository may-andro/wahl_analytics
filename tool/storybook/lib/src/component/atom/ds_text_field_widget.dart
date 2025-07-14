import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:storybook/src/model/option.dart';
import 'package:storybook/src/widget/base_scaffold_widget.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Text Field Widget', type: TextFieldWidget)
TextFieldWidget textFieldWidget(BuildContext context) {
  return const TextFieldWidget();
}

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldWidget(
      title: 'DSTextFieldWidget',
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(context.space(factor: 2)),
          child: DSTextFieldWidget(
            labelText: context.knobs
                .list<Option<String?>>(
                  label: 'Label Text',
                  options: <Option<String?>>[
                    Option(null, 'None'),
                    Option('Example Label Text', 'With Label'),
                  ],
                  labelBuilder: (option) => option.label,
                )
                .value,
            hintText: context.knobs
                .list<Option<String?>>(
                  label: 'Hint Text',
                  options: <Option<String?>>[
                    Option(null, 'None'),
                    Option('Example Hint Text', 'With Hint'),
                  ],
                  labelBuilder: (option) => option.label,
                )
                .value,
            helperText: context.knobs
                .list<Option<String?>>(
                  label: 'Helper Text',
                  options: <Option<String?>>[
                    Option(null, 'None'),
                    Option('Example Helper Text', 'With Helper'),
                  ],
                  labelBuilder: (option) => option.label,
                )
                .value,
            autofillHints: context.knobs
                .list<Option<List<String>?>>(
                  label: 'Autofill Hints',
                  options: <Option<List<String>?>>[
                    Option(null, 'None'),
                    Option([
                      'Autofill Hint 1',
                      'Autofill Hint 2',
                    ], 'With Autofill Hints'),
                  ],
                  labelBuilder: (option) => option.label,
                )
                .value,
            autofocus: context.knobs
                .list<Option<bool>>(
                  label: 'Autofocus?',
                  options: <Option<bool>>[
                    Option(false, 'No'),
                    Option(true, 'Yes'),
                  ],
                  labelBuilder: (option) => option.label,
                )
                .value,
            enabled: context.knobs
                .list<Option<bool>>(
                  label: 'Enabled?',
                  options: <Option<bool>>[
                    Option(true, 'Yes'),
                    Option(false, 'No'),
                  ],
                  labelBuilder: (option) => option.label,
                )
                .value,
            readOnly: context.knobs
                .list<Option<bool>>(
                  label: 'Read Only?',
                  options: <Option<bool>>[
                    Option(false, 'No'),
                    Option(true, 'Yes'),
                  ],
                  labelBuilder: (option) => option.label,
                )
                .value,
            maxLines: context.knobs
                .list<Option<int>>(
                  label: 'Max Lines',
                  options: <Option<int>>[
                    Option(1, 'Default: 1'),
                    Option(2, '2 lines'),
                    Option(5, '5 lines'),
                  ],
                  labelBuilder: (option) => option.label,
                )
                .value,
            maxLength: context.knobs
                .list<Option<int?>>(
                  label: 'Max Length',
                  options: <Option<int?>>[
                    Option(null, 'None'),
                    Option(10, '10'),
                    Option(50, '50'),
                  ],
                  labelBuilder: (option) => option.label,
                )
                .value,
            keyboardType: context.knobs
                .list<Option<TextInputType?>>(
                  label: 'Keyboard Type',
                  options: <Option<TextInputType?>>[
                    Option(null, 'None'),
                    Option(TextInputType.name, 'Name'),
                    Option(TextInputType.text, 'Text'),
                    Option(TextInputType.phone, 'Phone'),
                    Option(TextInputType.emailAddress, 'Email'),
                    Option(TextInputType.datetime, 'Datetime'),
                    Option(TextInputType.multiline, 'Multiline'),
                  ],
                  labelBuilder: (option) => option.label,
                )
                .value,
            autoValidateMode: context.knobs
                .list<Option<AutovalidateMode>>(
                  label: 'Auto Validate Mode',
                  options: <Option<AutovalidateMode>>[
                    Option(AutovalidateMode.disabled, 'Disabled [Default]'),
                    Option(AutovalidateMode.always, 'Always'),
                    Option(
                      AutovalidateMode.onUserInteraction,
                      'On User Interaction',
                    ),
                  ],
                  labelBuilder: (option) => option.label,
                )
                .value,
            textCapitalization: context.knobs
                .list<Option<TextCapitalization>>(
                  label: 'Text Capitalization',
                  options: <Option<TextCapitalization>>[
                    Option(TextCapitalization.none, 'None [Default]'),
                    Option(TextCapitalization.characters, 'Characters'),
                    Option(TextCapitalization.words, 'Words'),
                    Option(TextCapitalization.sentences, 'Sentences'),
                  ],
                  labelBuilder: (option) => option.label,
                )
                .value,
            suffixIcon: context.knobs
                .list<Option<IconData?>>(
                  label: 'Suffix Icon',
                  options: <Option<IconData?>>[
                    Option(null, 'None'),
                    Option(Icons.add, 'With Icon'),
                  ],
                  labelBuilder: (option) => option.label,
                )
                .value,
            textInputAction: context.knobs
                .list<Option<TextInputAction?>>(
                  label: 'Text Input Action',
                  options: <Option<TextInputAction?>>[
                    Option(null, 'None'),
                    Option(TextInputAction.next, 'Next'),
                    Option(TextInputAction.newline, 'New Line'),
                    Option(TextInputAction.previous, 'Previous'),
                    Option(TextInputAction.done, 'Done'),
                    Option(TextInputAction.search, 'Search'),
                    Option(TextInputAction.go, 'Go'),
                    Option(TextInputAction.continueAction, 'Continue Action'),
                  ],
                  labelBuilder: (option) => option.label,
                )
                .value,
            textFieldType: context.knobs
                .list<Option<TextFieldType>>(
                  label: 'Text Field Type',
                  options: <Option<TextFieldType>>[
                    Option(TextFieldType.normal, 'Normal'),
                    Option(TextFieldType.password, 'Password'),
                  ],
                  labelBuilder: (option) => option.label,
                )
                .value,
            onChanged: context.knobs
                .list<Option<void Function(String)?>>(
                  label: 'On Change Behaviour',
                  description: 'Select the clickable action behaviour',
                  options: <Option<void Function(String)?>>[
                    Option(null, 'Default [Non Clickable]'),
                    Option((String value) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text('Value: $value')));
                    }, 'With Action'),
                  ],
                  labelBuilder: (option) => option.label,
                )
                .value,
            onFieldSubmitted: context.knobs
                .list<Option<void Function(String)?>>(
                  label: 'Field Submit Action',
                  options: <Option<void Function(String)?>>[
                    Option(null, 'Default [No Action]'),
                    Option((String value) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text('Value: $value')));
                    }, 'With Action'),
                  ],
                  labelBuilder: (option) => option.label,
                )
                .value,
            validator: context.knobs
                .list<Option<TextFieldValidationData? Function(String?)?>>(
                  label: 'Validator',
                  options: [
                    Option(null, 'Default [No Validation]'),
                    Option((String? value) {
                      if (value == null || value.length < 2) {
                        return const TextFieldValidationData.error(
                          'Provide at least 2 characters',
                        );
                      }
                      if (value.length > 10) {
                        return const TextFieldValidationData.error(
                          'Too big text',
                        );
                      }

                      if (value.length > 3 && value.length < 7) {
                        return const TextFieldValidationData.success('Perfect');
                      }
                      return null;
                    }, 'With Validation'),
                  ],
                  labelBuilder: (option) => option.label,
                )
                .value,
            onValidationError: context.knobs
                .list<Option<void Function(String)?>>(
                  label: 'Validation Error Action',
                  description:
                      'Select the on validation error action behaviour',
                  options: [
                    Option(null, 'Default [No Action]'),
                    Option((String value) {}, 'Enabled'),
                  ],
                  labelBuilder: (option) => option.label,
                )
                .value,
            inputFormatters: context.knobs
                .list<Option<List<TextInputFormatter>?>>(
                  label: 'Input Formatters',
                  options: <Option<List<TextInputFormatter>?>>[
                    Option(null, 'None'),
                    Option([_TrimmingTextInputFormatter()], 'With Formatter'),
                  ],
                  labelBuilder: (option) => option.label,
                )
                .value,
          ),
        ),
      ),
    );
  }
}

class _TrimmingTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isNotEmpty) {
      final trimmed = newValue.text.trim();

      if (trimmed == oldValue.text) {
        return oldValue;
      }

      return TextEditingValue(
        text: trimmed,
        selection: TextSelection.collapsed(
          offset: newValue.selection.baseOffset.clamp(0, trimmed.length),
        ),
      );
    }

    return newValue;
  }
}
