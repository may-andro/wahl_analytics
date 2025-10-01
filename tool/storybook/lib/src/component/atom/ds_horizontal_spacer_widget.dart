import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:storybook/src/model/option.dart';
import 'package:storybook/src/widget/base_scaffold_widget.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Horizontal Spacer Widget',
  type: HorizontalSpacerWidget,
)
HorizontalSpacerWidget horizontalSpacerWidget(BuildContext context) {
  return const HorizontalSpacerWidget();
}

class HorizontalSpacerWidget extends StatelessWidget {
  const HorizontalSpacerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldWidget(
      title: 'DSHorizontalSpacerWidget',
      child: Center(
        child: Container(
          width: context.width,
          height: context.space(factor: 5),
          color: context.colorPalette.brand.primary.color,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: context.space(factor: 5),
                  color: context.colorPalette.background.primary.color,
                ),
              ),
              DSHorizontalSpacerWidget(
                context.knobs.object
                    .dropdown<Option<double>>(
                      label: 'Space Factor',
                      options: <Option<double>>[
                        Option(1, 'Factor 1'),
                        Option(2, 'Factor 2'),
                        Option(4, 'Factor 4'),
                        Option(8, 'Factor 8'),
                      ],
                      labelBuilder: (option) => option.label,
                    )
                    .value,
              ),
              Expanded(
                child: Container(
                  height: context.space(factor: 5),
                  color: context.colorPalette.background.primary.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
