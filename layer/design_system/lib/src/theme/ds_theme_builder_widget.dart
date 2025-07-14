import 'package:design_system/src/design_system/design_system.dart';
import 'package:design_system/src/theme/ds_theme.dart';
import 'package:design_system/src/theme/ds_theme_widget.dart';
import 'package:flutter/material.dart';

class DSThemeBuilderWidget extends StatelessWidget {
  const DSThemeBuilderWidget({
    super.key,
    required this.designSystem,
    required this.brightness,
    required this.child,
  });

  final DesignSystem designSystem;
  final Brightness brightness;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return _TextScaleClampWidget(
      builder: (textScale) {
        final theme = DSTheme(
          brightness: brightness,
          designSystem: designSystem,
        );
        return DSThemeWidget(dsTheme: theme, child: child);
      },
    );
  }
}

class _TextScaleClampWidget extends StatelessWidget {
  const _TextScaleClampWidget({required this.builder});

  final Widget Function(TextScaler textScaler) builder;

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final constrainedTextScaleFactor = mediaQueryData.textScaler.clamp(
      minScaleFactor: 0.75,
      maxScaleFactor: 1.5,
    );
    return MediaQuery(
      data: mediaQueryData.copyWith(textScaler: constrainedTextScaleFactor),
      child: builder(constrainedTextScaleFactor),
    );
  }
}
