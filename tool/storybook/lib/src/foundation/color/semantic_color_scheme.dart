import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:storybook/src/foundation/color/color_avatar_widget.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Semantic Color Scheme', type: SemanticColorScheme)
SemanticColorScheme semanticColorScheme(BuildContext context) {
  return const SemanticColorScheme();
}

class SemanticColorScheme extends StatelessWidget {
  const SemanticColorScheme({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorPalette.semantic;
    return ColorAvatarBuilderWidget([
      ColorAvatar(colorScheme.info.color, 'Info'),
      ColorAvatar(colorScheme.onInfo.color, 'On Info'),
      ColorAvatar(colorScheme.infoContainer.color, 'Info Container'),
      ColorAvatar(colorScheme.onInfoContainer.color, 'On Info Container'),
      ColorAvatar(colorScheme.success.color, 'Success'),
      ColorAvatar(colorScheme.onSuccess.color, 'On Success'),
      ColorAvatar(colorScheme.successContainer.color, 'Success Container'),
      ColorAvatar(colorScheme.onSuccessContainer.color, 'On Success Container'),
      ColorAvatar(colorScheme.warning.color, 'Warning'),
      ColorAvatar(colorScheme.onWarning.color, 'On Warning'),
      ColorAvatar(colorScheme.warningContainer.color, 'Warning Container'),
      ColorAvatar(colorScheme.onWarningContainer.color, 'On Warning Container'),
      ColorAvatar(colorScheme.error.color, 'Error'),
      ColorAvatar(colorScheme.onError.color, 'On Error'),
      ColorAvatar(colorScheme.errorContainer.color, 'Error Container'),
      ColorAvatar(colorScheme.onErrorContainer.color, 'On Error Container'),
    ], title: 'Semantic Color Scheme');
  }
}
