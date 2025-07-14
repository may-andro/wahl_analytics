import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:storybook/src/foundation/color/color_avatar_widget.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Neutral Color Scheme', type: NeutralColorScheme)
NeutralColorScheme neutralColorScheme(BuildContext context) {
  return const NeutralColorScheme();
}

class NeutralColorScheme extends StatelessWidget {
  const NeutralColorScheme({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorPalette.neutral;
    return ColorAvatarBuilderWidget([
      ColorAvatar(colorScheme.white.color, 'White'),
      ColorAvatar(colorScheme.black.color, 'Black'),
      ColorAvatar(colorScheme.grey1.color, 'Grey 1'),
      ColorAvatar(colorScheme.grey2.color, 'Grey 2'),
      ColorAvatar(colorScheme.grey3.color, 'Grey 3'),
      ColorAvatar(colorScheme.grey4.color, 'Grey 4'),
      ColorAvatar(colorScheme.grey5.color, 'Grey 5'),
      ColorAvatar(colorScheme.grey6.color, 'Grey 6'),
      ColorAvatar(colorScheme.grey7.color, 'Grey 7'),
      ColorAvatar(colorScheme.grey8.color, 'Grey 8'),
      ColorAvatar(colorScheme.grey9.color, 'Grey 9'),
      ColorAvatar(colorScheme.grey10.color, 'Grey 10'),
    ], title: 'Neutral Color Scheme');
  }
}
