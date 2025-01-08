import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:storybook/src/foundation/color/color_avatar_widget.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Brand Color Scheme',
  type: BrandColorScheme,
)
BrandColorScheme brandColorScheme(BuildContext context) {
  return const BrandColorScheme();
}

class BrandColorScheme extends StatelessWidget {
  const BrandColorScheme({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorPalette.brand;
    return ColorAvatarBuilderWidget(
      [
        ColorAvatar(colorScheme.primary.color, 'Primary'),
        ColorAvatar(colorScheme.onPrimary.color, 'On Primary'),
        ColorAvatar(colorScheme.primaryContainer.color, 'Primary Container'),
        ColorAvatar(
          colorScheme.onPrimaryContainer.color,
          'On Primary Container',
        ),
        ColorAvatar(colorScheme.secondary.color, 'Secondary'),
        ColorAvatar(colorScheme.onSecondary.color, 'On Secondary'),
        ColorAvatar(
          colorScheme.secondaryContainer.color,
          'Secondary Container',
        ),
        ColorAvatar(
          colorScheme.onSecondaryContainer.color,
          'On Secondary Container',
        ),
        ColorAvatar(colorScheme.tertiary.color, 'Tertiary'),
        ColorAvatar(colorScheme.onTertiary.color, 'On Tertiary'),
        ColorAvatar(colorScheme.tertiaryContainer.color, 'Tertiary Container'),
        ColorAvatar(
          colorScheme.onTertiaryContainer.color,
          'On Tertiary Container',
        ),
      ],
      title: 'Brand Color Scheme',
    );
  }
}
