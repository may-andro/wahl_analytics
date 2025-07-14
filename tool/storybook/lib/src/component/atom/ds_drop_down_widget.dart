import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:storybook/src/model/option.dart';
import 'package:storybook/src/widget/base_scaffold_widget.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Drop Down Widget', type: DropDownWidget)
DropDownWidget dropDownWidget(BuildContext context) {
  return const DropDownWidget();
}

class DropDownWidget extends StatefulWidget {
  const DropDownWidget({super.key});

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  List<String>? dropDownItems;
  String? selectedItem;

  @override
  void initState() {
    dropDownItems = [
      'Option 1',
      'Option 2',
      '1',
      'Too long option, invalid option',
    ];
    selectedItem = dropDownItems?.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldWidget(
      title: 'DSDropDownWidget',
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(context.space(factor: 2)),
          child: DSDropDownWidget<String>(
            items: dropDownItems?.map((value) {
              return DropdownMenuItem(
                value: value,
                child: DSTextWidget(
                  value,
                  color: context.colorPalette.neutral.grey9,
                  style: context.typography.bodyLarge,
                ),
              );
            }).toList(),
            value: selectedItem,
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
            onChanged: context.knobs
                .list<Option<ValueChanged<String?>?>>(
                  label: 'On Change Behaviour',
                  description: 'Select the clickable action behaviour',
                  options: <Option<ValueChanged<String?>?>>[
                    Option(null, 'Default [Non Clickable]'),
                    Option((value) {
                      setState(() {
                        selectedItem = value;
                      });
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text('Value: $value')));
                    }, 'With Action'),
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
            onTap: context.knobs
                .list<Option<VoidCallback?>>(
                  label: 'Field Submit Action',
                  options: <Option<VoidCallback?>>[
                    Option(null, 'Default [No Action]'),
                    Option(() {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text('On Tapped')));
                    }, 'With Action'),
                  ],
                  labelBuilder: (option) => option.label,
                )
                .value,
            validator: context.knobs
                .list<Option<DropDownValidationData? Function(String?)?>>(
                  label: 'Validator',
                  options: [
                    Option(null, 'Default [No Validation]'),
                    Option((String? value) {
                      if (value == null || value.length < 2) {
                        return const DropDownValidationData.error(
                          'Provide at least 2 characters',
                        );
                      }
                      if (value.length > 10) {
                        return const DropDownValidationData.error(
                          'Too big text',
                        );
                      }

                      if (value.length > 3 && value.length < 7) {
                        return const DropDownValidationData.success('Perfect');
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
          ),
        ),
      ),
    );
  }
}
