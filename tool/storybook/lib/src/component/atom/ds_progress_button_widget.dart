import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:storybook/src/model/option.dart';
import 'package:storybook/src/widget/base_scaffold_widget.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Progress Button Widget',
  type: ProgressButtonWidget,
)
ProgressButtonWidget progressButtonWidget(BuildContext context) {
  return const ProgressButtonWidget();
}

class ProgressButtonWidget extends StatelessWidget {
  const ProgressButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldWidget(
      title: 'DSProgressButtonWidget',
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(context.space(factor: 2)),
          child: DSProgressButtonWidget(
            label: 'Loading Button Widget',
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
            border: context.knobs
                .list<Option<DSProgressButtonBorder>>(
                  label: 'Border',
                  options: [
                    Option(DSProgressButtonBorder.regular, 'Regular'),
                    Option(DSProgressButtonBorder.rounded, 'Rounded'),
                  ],
                  labelBuilder: (option) => option.label,
                )
                .value,
            isDisabled: context.knobs
                .list<Option<bool>>(
                  label: 'Is Disabled?',
                  options: <Option<bool>>[
                    Option(false, 'No'),
                    Option(true, 'Yes'),
                  ],
                  labelBuilder: (option) => option.label,
                )
                .value,
            size: context.knobs
                .list<Option<DSProgressButtonSize>>(
                  label: 'Size',
                  options: [
                    Option(DSProgressButtonSize.large, 'Large'),
                    Option(DSProgressButtonSize.medium, 'Medium'),
                    Option(DSProgressButtonSize.small, 'Small'),
                  ],
                  labelBuilder: (option) => option.label,
                )
                .value,
            icon: context.knobs
                .list<Option<IconData?>>(
                  label: 'Icon',
                  options: [
                    Option(null, 'None'),
                    Option(Icons.add, 'With Icon'),
                  ],
                  labelBuilder: (option) => option.label,
                )
                .value,
            iconDirection: context.knobs
                .list<Option<DSProgressButtonIconDirection>>(
                  label: 'Icon Direction',
                  options: [
                    Option(DSProgressButtonIconDirection.left, 'Left'),
                    Option(DSProgressButtonIconDirection.right, 'Right'),
                  ],
                  labelBuilder: (option) => option.label,
                )
                .value,
            loadingPercentage: context.knobs
                .list<Option<double?>>(
                  label: 'Loading Percentage',
                  options: [
                    Option(null, 'None'),
                    Option(0, '0%'),
                    Option(0.25, '25%'),
                    Option(0.50, '50%'),
                    Option(0.75, '75%'),
                    Option(1, '100%'),
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
