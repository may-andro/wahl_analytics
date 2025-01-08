import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:storybook/src/model/option.dart';
import 'package:storybook/src/widget/base_scaffold_widget.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Radius',
  type: RadiusDimension,
)
RadiusDimension radiusDimension(BuildContext context) {
  return const RadiusDimension();
}

class RadiusDimension extends StatelessWidget {
  const RadiusDimension({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldWidget(
      title: 'Radius',
      child: Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                context.knobs
                    .list<Option<double>>(
                      label: 'Radius Type',
                      options: <Option<double>>[
                        Option(context.dimen.radiusLevel1.value, 'Level1'),
                        Option(context.dimen.radiusLevel2.value, 'Level2'),
                        Option(context.dimen.radiusLevel3.value, 'Level3'),
                        Option(context.dimen.radiusCircular.value, 'Circular'),
                      ],
                      labelBuilder: (option) => option.label,
                    )
                    .value,
              ),
            ),
          ),
          color: context.colorPalette.brand.primary.color,
          child: const SizedBox(height: 120, width: 120),
        ),
      ),
    );
  }
}
