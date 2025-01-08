import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:storybook/src/foundation/color/color_avatar_widget.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Background Color Scheme',
  type: BackgroundColorScheme,
)
BackgroundColorScheme backgroundColorScheme(BuildContext context) {
  return const BackgroundColorScheme();
}

class BackgroundColorScheme extends StatelessWidget {
  const BackgroundColorScheme({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorPalette.background;
    return ColorAvatarBuilderWidget(
      [
        ColorAvatar(colorScheme.primary.color, 'Primary'),
        ColorAvatar(colorScheme.onPrimary.color, 'On Primary'),
        ColorAvatar(colorScheme.surface.color, 'Surface'),
        ColorAvatar(colorScheme.onSurface.color, 'On Surface'),
        ColorAvatar(colorScheme.disabled.color, 'Disabled'),
        ColorAvatar(colorScheme.onDisabled.color, 'On Disabled'),
        ColorAvatar(colorScheme.surfaceVariant.color, 'Surface Variant'),
        ColorAvatar(colorScheme.onSurfaceVariant.color, 'On Surface Variant'),
        ColorAvatar(colorScheme.inverseSurface.color, 'Inverse Variant'),
        ColorAvatar(colorScheme.onInverseSurface.color, 'On Inverse Variant'),
        ColorAvatar(colorScheme.scrim.color, 'Scrim'),
        ColorAvatar(colorScheme.shadow.color, 'Shadow'),
      ],
      title: 'Background Color Scheme',
    );
  }
}
