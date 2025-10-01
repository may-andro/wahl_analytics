import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:storybook/src/model/option.dart';
import 'package:storybook/src/widget/base_scaffold_widget.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Animated Text Widget', type: AnimatedTextWidget)
AnimatedTextWidget animatedTextWidget(BuildContext context) {
  return const AnimatedTextWidget();
}

class AnimatedTextWidget extends StatelessWidget {
  const AnimatedTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldWidget(
      title: 'DSAnimatedTextWidget',
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(context.space(factor: 2)),
          child: DSAnimatedTextWidget(
            texts: const [
              'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto.',
              'Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen.',
            ],
            color: context.knobs.object
                .dropdown<Option<DSColor>>(
                  label: 'Text Color',
                  options: <Option<DSColor>>[
                    Option(context.colorPalette.neutral.grey9, 'Grey Level 9'),
                    Option(context.colorPalette.neutral.grey7, 'Grey Level 7'),
                    Option(context.colorPalette.brand.primary, 'Primary'),
                    Option(context.colorPalette.brand.secondary, 'Secondary'),
                  ],
                  labelBuilder: (option) => option.label,
                )
                .value,
            style: context.knobs.object
                .dropdown<Option<DSTextStyle>>(
                  label: 'Typography',
                  options: <Option<DSTextStyle>>[
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
          ),
        ),
      ),
    );
  }
}
