import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class BaseScaffoldWidget extends StatelessWidget {
  const BaseScaffoldWidget({
    required this.title,
    required this.child,
    super.key,
  });

  final String title;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorPalette.background.primary.color,
      appBar: AppBar(
        title: Text(
          title,
          style: context.typography.titleMedium.textStyle.copyWith(
            color: context.colorPalette.neutral.white.color,
          ),
        ),
        backgroundColor: context.colorPalette.brand.primary.color,
      ),
      body: child,
    );
  }
}
