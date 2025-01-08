import 'package:design_system/src/design_system/design_system.dart';
import 'package:design_system/src/theme/theme.dart';
import 'package:flutter/material.dart';

class TestWidgetWrapper extends StatelessWidget {
  const TestWidgetWrapper({
    super.key,
    required this.brightness,
    required this.designSystem,
    required this.child,
  });

  final Brightness brightness;
  final DesignSystem designSystem;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (_, child) {
        return DSThemeBuilderWidget(
          brightness: brightness,
          designSystem: designSystem,
          child: child!,
        );
      },
      home: Scaffold(body: child),
    );
  }
}
