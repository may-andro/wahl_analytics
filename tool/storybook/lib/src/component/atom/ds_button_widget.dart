import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:storybook/src/model/option.dart';
import 'package:storybook/src/widget/base_scaffold_widget.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Button Widget', type: ButtonWidget)
ButtonWidget buttonWidget(BuildContext context) {
  return const ButtonWidget();
}

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldWidget(
      title: 'DSButtonWidget',
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(context.space(factor: 2)),
          child: DSButtonWidget(
            label: 'Button Widget',
            onPressed: () {
              final snackBar = SnackBar(
                content: DSTextWidget(
                  'On Clicked Action',
                  color: context.colorPalette.neutral.grey9,
                  style: context.typography.bodyMedium,
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            variant: context.knobs.object
                .dropdown<Option<DSButtonVariant>>(
                  label: 'Variant',
                  options: [
                    Option(DSButtonVariant.primary, 'Primary'),
                    Option(DSButtonVariant.secondary, 'Secondary'),
                    Option(DSButtonVariant.error, 'Error'),
                    Option(DSButtonVariant.text, 'Text'),
                    Option(DSButtonVariant.prominent, 'Prominent'),
                  ],
                  labelBuilder: (option) => option.label,
                )
                .value,
            border: context.knobs.object
                .dropdown<Option<DSButtonBorder>>(
                  label: 'Border',
                  options: [
                    Option(DSButtonBorder.regular, 'Regular'),
                    Option(DSButtonBorder.rounded, 'Rounded'),
                  ],
                  labelBuilder: (option) => option.label,
                )
                .value,
            isDisabled: context.knobs.object
                .dropdown<Option<bool>>(
                  label: 'Is Disabled',
                  options: <Option<bool>>[
                    Option(false, 'No'),
                    Option(true, 'Yes'),
                  ],
                  labelBuilder: (option) => option.label,
                )
                .value,
            isLoading: context.knobs.object
                .dropdown<Option<bool>>(
                  label: 'Is Loading?',
                  options: <Option<bool>>[
                    Option(false, 'No'),
                    Option(true, 'Yes'),
                  ],
                  labelBuilder: (option) => option.label,
                )
                .value,
            size: context.knobs.object
                .dropdown<Option<DSButtonSize>>(
                  label: 'Size',
                  options: <Option<DSButtonSize>>[
                    Option(DSButtonSize.large, 'Large'),
                    Option(DSButtonSize.medium, 'Medium'),
                    Option(DSButtonSize.small, 'Small'),
                  ],
                  labelBuilder: (option) => option.label,
                )
                .value,
            icon: context.knobs.object
                .dropdown<Option<IconData?>>(
                  label: 'Icon',
                  options: [
                    Option(null, 'None'),
                    Option(Icons.add, 'With Icon'),
                  ],
                  labelBuilder: (option) => option.label,
                )
                .value,
            iconDirection: context.knobs.object
                .dropdown<Option<DSButtonIconDirection>>(
                  label: 'Icon Direction',
                  options: [
                    Option(DSButtonIconDirection.left, 'Left'),
                    Option(DSButtonIconDirection.right, 'Right'),
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
