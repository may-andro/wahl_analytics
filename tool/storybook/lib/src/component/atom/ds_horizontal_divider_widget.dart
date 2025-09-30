import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:storybook/src/model/option.dart';
import 'package:storybook/src/widget/base_scaffold_widget.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Horizontal Divider Widget',
  type: HorizontalDividerWidget,
)
HorizontalDividerWidget horizontalDividerWidget(BuildContext context) {
  return const HorizontalDividerWidget();
}

class HorizontalDividerWidget extends StatelessWidget {
  const HorizontalDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldWidget(
      title: 'DSHorizontalDividerWidget',
      child: Center(
        child: DSHorizontalDividerWidget(
          color: context.knobs.object
              .dropdown<Option<DSColor>>(
                label: 'Color',
                options: <Option<DSColor>>[
                  Option(context.colorPalette.brand.primary, 'Brand Primary'),
                  Option(
                    context.colorPalette.semantic.success,
                    'Semantic Success',
                  ),
                  Option(context.colorPalette.semantic.error, 'Semantic Error'),
                  Option(context.colorPalette.semantic.info, 'Semantic Info'),
                ],
                labelBuilder: (option) => option.label,
              )
              .value,
          thickness: context.knobs.object
              .dropdown<Option<double>>(
                label: 'Thickness',
                options: <Option<double>>[
                  Option(1, '1 pixel'),
                  Option(2, '2 pixel'),
                  Option(4, '4 pixel'),
                  Option(8, '8 pixel'),
                ],
                labelBuilder: (option) => option.label,
              )
              .value,
        ),
      ),
    );
  }
}
