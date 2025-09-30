import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:storybook/src/model/option.dart';
import 'package:storybook/src/widget/base_scaffold_widget.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Elevation', type: ElevationDimension)
ElevationDimension elevationDimension(BuildContext context) {
  return const ElevationDimension();
}

class ElevationDimension extends StatelessWidget {
  const ElevationDimension({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldWidget(
      title: 'Elevation',
      child: Center(
        child: Card(
          elevation: context.knobs.object
              .dropdown<Option<double>>(
                label: 'Elevation Type',
                options: <Option<double>>[
                  Option(context.dimen.elevationLevel1.value, 'Level1'),
                  Option(context.dimen.elevationLevel2.value, 'Level2'),
                  Option(context.dimen.elevationLevel3.value, 'Level3'),
                  Option(context.dimen.elevationNone.value, 'None'),
                ],
                labelBuilder: (option) => option.label,
              )
              .value,
          color: context.colorPalette.brand.primary.color,
          child: const SizedBox(height: 120, width: 120),
        ),
      ),
    );
  }
}
