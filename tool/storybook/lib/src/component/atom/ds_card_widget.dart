import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:storybook/src/model/option.dart';
import 'package:storybook/src/widget/base_scaffold_widget.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Card Widget', type: CardWidget)
CardWidget cardWidget(BuildContext context) {
  return const CardWidget();
}

class CardWidget extends StatelessWidget {
  const CardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldWidget(
      title: 'DsCardWidget',
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(context.space(factor: 2)),
          child: DsCardWidget(
            backgroundColor: context.knobs.object
                .dropdown<Option<DSColor?>>(
                  label: 'Background Color',
                  options: <Option<DSColor?>>[
                    Option(null, 'None'),
                    Option(
                      context.colorPalette.background.primary,
                      'Background Primary',
                    ),
                    Option(
                      context.colorPalette.background.surface,
                      'Background Surface',
                    ),
                    Option(
                      context.colorPalette.backgroundSecondary.primary,
                      'BackgroundSecondary Primary',
                    ),
                    Option(
                      context.colorPalette.backgroundSecondary.surface,
                      'BackgroundSecondary Surface',
                    ),
                    Option(context.colorPalette.brand.primary, 'Brand Primary'),
                    Option(
                      context.colorPalette.semantic.success,
                      'Semantic Success',
                    ),
                    Option(
                      context.colorPalette.semantic.error,
                      'Semantic Error',
                    ),
                    Option(context.colorPalette.semantic.info, 'Semantic Info'),
                  ],
                  labelBuilder: (option) => option.label,
                )
                .value,
            splashColor: context.knobs.object
                .dropdown<Option<DSColor?>>(
                  label: 'Splash Color',
                  options: <Option<DSColor?>>[
                    Option(null, 'None'),
                    Option(context.colorPalette.brand.primary, 'Brand Primary'),
                    Option(
                      context.colorPalette.semantic.success,
                      'Semantic Success',
                    ),
                    Option(
                      context.colorPalette.semantic.error,
                      'Semantic Error',
                    ),
                    Option(context.colorPalette.semantic.info, 'Semantic Info'),
                  ],
                  labelBuilder: (option) => option.label,
                )
                .value,
            shadowColor: context.knobs.object
                .dropdown<Option<DSColor?>>(
                  label: 'Shadow Color',
                  options: <Option<DSColor?>>[
                    Option(null, 'None'),
                    Option(context.colorPalette.brand.primary, 'Brand Primary'),
                    Option(
                      context.colorPalette.semantic.success,
                      'Semantic Success',
                    ),
                    Option(
                      context.colorPalette.semantic.error,
                      'Semantic Error',
                    ),
                    Option(context.colorPalette.semantic.info, 'Semantic Info'),
                  ],
                  labelBuilder: (option) => option.label,
                )
                .value,
            surfaceTintColor: context.knobs.object
                .dropdown<Option<DSColor?>>(
                  label: 'Surface Tine Color',
                  options: <Option<DSColor?>>[
                    Option(null, 'None'),
                    Option(context.colorPalette.brand.primary, 'Brand Primary'),
                    Option(
                      context.colorPalette.semantic.success,
                      'Semantic Success',
                    ),
                    Option(
                      context.colorPalette.semantic.error,
                      'Semantic Error',
                    ),
                    Option(context.colorPalette.semantic.info, 'Semantic Info'),
                  ],
                  labelBuilder: (option) => option.label,
                )
                .value,
            radius: context.knobs.object
                .dropdown<Option<DSRadius?>>(
                  label: 'Radius',
                  options: <Option<DSRadius?>>[
                    Option(null, 'None'),
                    Option(context.dimen.radiusLevel1, 'Radius Level1'),
                    Option(context.dimen.radiusLevel2, 'Radius Level2'),
                    Option(context.dimen.radiusLevel3, 'Radius Level3'),
                    Option(context.dimen.radiusCircular, 'Radius Circular'),
                  ],
                  labelBuilder: (option) => option.label,
                )
                .value,
            elevation: context.knobs.object
                .dropdown<Option<DSElevation?>>(
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
            backgroundColorOpacity: context.knobs.object
                .dropdown<Option<double>>(
                  label: 'Background Color Opacity',
                  options: <Option<double>>[
                    Option(1.0, '100% Opacity'),
                    Option(0.8, '80% Opacity'),
                    Option(0.6, '60% Opacity'),
                    Option(0.4, '40% Opacity'),
                    Option(0.2, '20% Opacity'),
                  ],
                  labelBuilder: (option) => option.label,
                )
                .value,
            margin: context.knobs.object
                .dropdown<Option<EdgeInsetsGeometry?>>(
                  label: 'Margin',
                  options: <Option<EdgeInsetsGeometry?>>[
                    Option(null, 'None'),
                    Option(const EdgeInsets.all(8), '8 pixel'),
                    Option(const EdgeInsets.all(16), '16 pixel'),
                    Option(const EdgeInsets.all(24), '24 pixel'),
                  ],
                  labelBuilder: (option) => option.label,
                )
                .value,
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.all(context.space(factor: 2)),
              child: DSTextWidget(
                'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen.',
                color: context.colorPalette.brand.primary,
                style: context.typography.labelMedium,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
