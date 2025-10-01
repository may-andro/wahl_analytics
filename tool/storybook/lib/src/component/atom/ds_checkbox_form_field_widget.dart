import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:storybook/src/model/option.dart';
import 'package:storybook/src/widget/base_scaffold_widget.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Checkbox Form Field Widget',
  type: CheckboxFormFieldWidget,
)
CheckboxFormFieldWidget checkboxFormFieldWidget(BuildContext context) {
  return const CheckboxFormFieldWidget();
}

class CheckboxFormFieldWidget extends StatelessWidget {
  const CheckboxFormFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldWidget(
      title: 'DSCheckboxFormFieldWidget',
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(context.space(factor: 2)),
          child: DSCheckboxFormFieldWidget(
            onSaved: (value) {
              final snackBar = SnackBar(
                content: DSTextWidget(
                  'Value changed: $value',
                  color: context.colorPalette.neutral.grey9,
                  style: context.typography.bodyMedium,
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            validator: (value) {
              if (value == null) {
                return 'No value found';
              }
              return null;
            },
            isDisabled: context.knobs.object
                .dropdown<Option<bool>>(
                  label: 'Disabled',
                  options: <Option<bool>>[
                    Option(false, 'No'),
                    Option(true, 'Yes'),
                  ],
                  labelBuilder: (option) => option.label,
                )
                .value,
            isTriStateEnabled: context.knobs.object
                .dropdown<Option<bool>>(
                  label: 'Is TriState Enabled',
                  options: <Option<bool>>[
                    Option(false, 'No'),
                    Option(true, 'Yes'),
                  ],
                  labelBuilder: (option) => option.label,
                )
                .value,
            label: 'This is a label text',
          ),
        ),
      ),
    );
  }
}
