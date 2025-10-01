import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:storybook/src/model/option.dart';
import 'package:storybook/src/widget/base_scaffold_widget.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Mason Staggered Grid Widget',
  type: MasonStaggeredGridWidget,
)
MasonStaggeredGridWidget masonStaggeredGridWidget(BuildContext context) {
  return const MasonStaggeredGridWidget();
}

class MasonStaggeredGridWidget extends StatelessWidget {
  const MasonStaggeredGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldWidget(
      title: 'DSMasonStaggeredGridWidget',
      child: Center(
        child: SingleChildScrollView(
          child: DSMasonStaggeredGridWidget(
            crossAxisCount: context.knobs.object
                .dropdown<Option<int>>(
                  label: 'Cross Axis Count',
                  options: [
                    Option(1, '1'),
                    Option(2, '2'),
                    Option(4, '4'),
                    Option(8, '8'),
                  ],
                  labelBuilder: (option) => option.label,
                )
                .value,
            itemCount: 10,
            mainAxisSpacing: context.knobs.object
                .dropdown<Option<double>>(
                  label: 'Main Axis Spacing',
                  options: [
                    Option(0.0, '0.0 [default]'),
                    Option(2.0, '2.0'),
                    Option(4.0, '4.0'),
                    Option(8.0, '8.0'),
                  ],
                  labelBuilder: (option) => option.label,
                )
                .value,
            crossAxisSpacing: context.knobs.object
                .dropdown<Option<double>>(
                  label: 'Cross Axis Spacing',
                  options: [
                    Option(0.0, '0.0 [default]'),
                    Option(2.0, '2.0'),
                    Option(4.0, '4.0'),
                    Option(8.0, '8.0'),
                  ],
                  labelBuilder: (option) => option.label,
                )
                .value,
            itemBuilder: (context, index) {
              return DsCardWidget(
                backgroundColor: context.colorPalette.semantic.warning,
                elevation: context.dimen.elevationLevel3,
                radius: context.dimen.radiusLevel3,
                margin: EdgeInsets.all(context.space(factor: 2)),
                child: Padding(
                  padding: EdgeInsets.all(context.space(factor: 2)),
                  child: Center(
                    child: DSTextWidget(
                      'Card Item: $index',
                      color: context.colorPalette.semantic.onWarning,
                      style: context.typography.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
