import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:storybook/src/widget/base_scaffold_widget.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Typography',
  type: Typography,
)
Typography typography(BuildContext context) {
  return const Typography();
}

class Typography extends StatelessWidget {
  const Typography({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldWidget(
      title: 'Typography',
      child: ListView(
        children: [
          _ItemWidget(
            'Display Large',
            context.typography.displayLarge.textStyle,
          ),
          _ItemWidget(
            'Display Medium',
            context.typography.displayMedium.textStyle,
          ),
          _ItemWidget(
            'Display Small',
            context.typography.displaySmall.textStyle,
          ),
          _ItemWidget(
            'Headline Large',
            context.typography.headlineLarge.textStyle,
          ),
          _ItemWidget(
            'Headline Medium',
            context.typography.headlineMedium.textStyle,
          ),
          _ItemWidget(
            'Headline Small',
            context.typography.headlineSmall.textStyle,
          ),
          _ItemWidget(
            'Title Large',
            context.typography.titleLarge.textStyle,
          ),
          _ItemWidget(
            'Title Medium',
            context.typography.titleMedium.textStyle,
          ),
          _ItemWidget(
            'Title Small',
            context.typography.titleSmall.textStyle,
          ),
          _ItemWidget(
            'Body Large',
            context.typography.bodyLarge.textStyle,
          ),
          _ItemWidget(
            'Body Medium',
            context.typography.bodyMedium.textStyle,
          ),
          _ItemWidget(
            'Body Small',
            context.typography.bodySmall.textStyle,
          ),
          _ItemWidget(
            'Label Large',
            context.typography.labelLarge.textStyle,
          ),
          _ItemWidget(
            'Label Medium',
            context.typography.labelMedium.textStyle,
          ),
          _ItemWidget(
            'Label Small',
            context.typography.labelSmall.textStyle,
          ),
        ],
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  const _ItemWidget(this.title, this.textStyle);

  final String title;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: context.space()),
      color: context.colorPalette.background.primary.color,
      child: ListTile(
        title: Text(
          title,
          style: textStyle.copyWith(
            color: context.colorPalette.neutral.grey9.color,
          ),
        ),
        subtitle: Text(
          textStyle.description,
          style: const TextStyle(fontSize: 9),
        ),
      ),
    );
  }
}

extension _TextStyleExtension on TextStyle {
  String get fontSize => 'Font Size: ${this.fontSize}';

  String get letterSpacing => 'Letter Spacing: ${this.letterSpacing}';

  String get fontWeight => 'Font Weight: ${this.fontWeight}';

  String get description => '$fontSize, $letterSpacing, $fontWeight';
}
