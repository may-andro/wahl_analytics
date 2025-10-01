import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:storybook/src/model/option.dart';
import 'package:storybook/src/widget/base_scaffold_widget.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

String _sampleText =
    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. '
    "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. "
    'It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. '
    'It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.';

@widgetbook.UseCase(name: 'Text Widget', type: TextWidget)
TextWidget textWidget(BuildContext context) {
  return const TextWidget();
}

class TextWidget extends StatelessWidget {
  const TextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldWidget(
      title: 'DSTextWidget',
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(context.space(factor: 2)),
          child: DSTextWidget(
            _sampleText,
            color: context.knobs.object
                .dropdown<Option<DSColor>>(
                  label: 'Color',
                  options: <Option<DSColor>>[
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
            style: context.knobs.object
                .dropdown<Option<DSTextStyle>>(
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
            decoration: context.knobs.object
                .dropdown<Option<TextDecoration>>(
                  label: 'Text Decoration',
                  description: 'Select the style',
                  options: [
                    Option(TextDecoration.none, 'none'),
                    Option(TextDecoration.overline, 'Over Line'),
                    Option(TextDecoration.lineThrough, 'Line Through'),
                    Option(TextDecoration.underline, 'Underline'),
                  ],
                  labelBuilder: (option) => option.label,
                )
                .value,
            softWrap: context.knobs.object
                .dropdown<Option<bool?>>(
                  label: 'SoftWrap',
                  description: 'Select the style',
                  options: [
                    Option(null, 'None'),
                    Option(false, 'No'),
                    Option(true, 'Yes'),
                  ],
                  labelBuilder: (option) => option.label,
                )
                .value,
            textOverflow: context.knobs.object
                .dropdown<Option<TextOverflow?>>(
                  label: 'TextOverflow',
                  description: 'Select the style',
                  options: [
                    Option(null, 'none'),
                    Option(TextOverflow.visible, 'Visible'),
                    Option(TextOverflow.clip, 'Clip'),
                    Option(TextOverflow.fade, 'Fade'),
                    Option(TextOverflow.ellipsis, 'Ellipsis'),
                  ],
                  labelBuilder: (option) => option.label,
                )
                .value,
            maxLines: context.knobs.object
                .dropdown<Option<int?>>(
                  label: 'Max Lines',
                  description: 'Select the style',
                  options: [
                    Option(null, 'none'),
                    Option(2, '2 lines'),
                    Option(4, '4 lines'),
                    Option(8, '8 lines'),
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
