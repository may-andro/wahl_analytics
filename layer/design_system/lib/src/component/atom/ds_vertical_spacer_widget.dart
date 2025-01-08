import 'package:design_system/src/extension/build_context_extension.dart';
import 'package:flutter/material.dart';

class DSVerticalSpacerWidget extends StatelessWidget {
  const DSVerticalSpacerWidget(this.factor, {super.key});

  final double factor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: context.space(factor: factor));
  }
}
