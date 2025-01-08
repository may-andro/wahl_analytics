import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:storybook/src/model/option.dart';
import 'package:storybook/src/widget/base_scaffold_widget.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Icon Title Tile Widget',
  type: IconTitleTileWidget,
)
IconTitleTileWidget iconTitleTileWidget(BuildContext context) {
  return const IconTitleTileWidget();
}

class IconTitleTileWidget extends StatelessWidget {
  const IconTitleTileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldWidget(
      title: 'DSIconTitleTileWidget',
      child: Center(
        child: DSIconTitleTileWidget(
          text: 'Some label text',
          icon: Icons.add,
          textColor: context.knobs
              .list<Option<DSColor>>(
                label: 'Color',
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
          style: context.knobs
              .list<Option<DSTextStyle>>(
                label: 'Text Style',
                description: 'Select the style',
                options: [
                  Option(context.typography.titleSmall, 'Title Small'),
                  Option(context.typography.titleMedium, 'Title Medium'),
                  Option(context.typography.titleLarge, 'Title Large'),
                  Option(context.typography.bodySmall, 'Body Small'),
                  Option(context.typography.bodyMedium, 'Body Medium'),
                  Option(context.typography.bodyLarge, 'Body Large'),
                  Option(context.typography.labelSmall, 'Label Small'),
                  Option(context.typography.labelMedium, 'Label Medium'),
                  Option(context.typography.labelLarge, 'label Large'),
                  Option(context.typography.headlineSmall, 'Headline Small'),
                  Option(
                    context.typography.headlineMedium,
                    'Headline Medium',
                  ),
                  Option(context.typography.headlineLarge, 'Headline Large'),
                ],
                labelBuilder: (option) => option.label,
              )
              .value,
          iconSize: context.knobs
              .list<Option<double?>>(
                label: 'Size',
                options: <Option<double?>>[
                  Option(null, 'Not Defined [Default]'),
                  Option(context.space(factor: 2), '16 pixel'),
                  Option(context.space(factor: 5), '40 pixel'),
                  Option(context.space(factor: 8), '64 pixel'),
                ],
                labelBuilder: (option) => option.label,
              )
              .value,
        ),
      ),
    );
  }
}
