import 'package:design_system/src/foundation/foundation.dart';
import 'package:flutter/material.dart';

class DSHorizontalDividerWidget extends StatelessWidget {
  const DSHorizontalDividerWidget({
    required this.thickness,
    required this.color,
    super.key,
  });

  final double thickness;
  final DSColor color;

  @override
  Widget build(BuildContext context) {
    return Divider(thickness: thickness, color: color.color);
  }
}
