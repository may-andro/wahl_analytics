import 'package:design_system/src/extension/ds_theme_extension.dart';
import 'package:design_system/src/theme/ds_theme.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@internal
final class DSThemeWidget extends InheritedWidget {
  DSThemeWidget({super.key, required this.dsTheme, required Widget child})
    : super(
        child: _ThemeWidget(dsTheme: dsTheme, child: child),
      );

  final DSTheme dsTheme;

  @override
  bool updateShouldNotify(covariant DSThemeWidget oldWidget) {
    return dsTheme != oldWidget.dsTheme;
  }

  static DSTheme of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DSThemeWidget>()!.dsTheme;
  }
}

class _ThemeWidget extends StatelessWidget {
  const _ThemeWidget({required this.dsTheme, required this.child});

  final Widget child;
  final DSTheme dsTheme;

  @override
  Widget build(BuildContext context) {
    return AnimatedTheme(data: dsTheme.theme, child: child);
  }
}
