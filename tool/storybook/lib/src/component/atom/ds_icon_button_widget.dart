import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:storybook/src/model/option.dart';
import 'package:storybook/src/widget/base_scaffold_widget.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Icon Button Widget',
  type: IconButtonWidget,
)
IconButtonWidget iconButtonWidget(BuildContext context) {
  return const IconButtonWidget();
}

class IconButtonWidget extends StatelessWidget {
  const IconButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldWidget(
      title: 'DSIconButtonWidget',
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(context.space(factor: 2)),
          child: DSIconButtonWidget(
            Icons.add,
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
            iconColor: context.knobs
                .list<Option<DSColor>>(
                  label: 'Icon Color',
                  options: <Option<DSColor>>[
                    Option(
                      context.colorPalette.neutral.white,
                      'White',
                    ),
                    Option(
                      context.colorPalette.brand.primary,
                      'Brand Primary',
                    ),
                    Option(
                      context.colorPalette.semantic.success,
                      'Semantic Success',
                    ),
                    Option(
                      context.colorPalette.semantic.error,
                      'Semantic Error',
                    ),
                    Option(
                      context.colorPalette.semantic.info,
                      'Semantic Info',
                    ),
                  ],
                  labelBuilder: (option) => option.label,
                )
                .value,
            buttonColor: context.knobs
                .list<Option<DSColor>>(
                  label: 'Button Color',
                  options: <Option<DSColor>>[
                    Option(
                      context.colorPalette.brand.primary,
                      'Brand Primary',
                    ),
                    Option(
                      context.colorPalette.semantic.success,
                      'Semantic Success',
                    ),
                    Option(
                      context.colorPalette.semantic.error,
                      'Semantic Error',
                    ),
                    Option(
                      context.colorPalette.semantic.info,
                      'Semantic Info',
                    ),
                  ],
                  labelBuilder: (option) => option.label,
                )
                .value,
            size: context.knobs
                .list<Option<DSIconButtonSize>>(
                  label: 'Size',
                  options: [
                    Option(DSIconButtonSize.large, 'Large'),
                    Option(DSIconButtonSize.medium, 'Medium'),
                    Option(DSIconButtonSize.small, 'Small'),
                  ],
                  labelBuilder: (option) => option.label,
                )
                .value,
            elevation: context.knobs
                .list<Option<DSElevation?>>(
                  label: 'Elevation',
                  options: <Option<DSElevation?>>[
                    Option(null, 'None'),
                    Option(context.dimen.elevationLevel1, 'Elevation Level1'),
                    Option(context.dimen.elevationLevel2, 'Elevation Level2'),
                    Option(context.dimen.elevationLevel3, 'Elevation Level3'),
                    Option(context.dimen.elevationNone, 'Elevation None'),
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
