import 'package:design_system/src/foundation/foundation.dart';
import 'package:flutter/material.dart';

class DSVerticalDividerWidget extends StatelessWidget {
  const DSVerticalDividerWidget({
    required this.thickness,
    required this.color,
    super.key,
  });

  final double thickness;
  final DSColor color;

  @override
  Widget build(BuildContext context) {
    return VerticalDivider(thickness: thickness, color: color.color);
  }
}
