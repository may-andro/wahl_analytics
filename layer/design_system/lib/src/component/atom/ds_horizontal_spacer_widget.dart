import 'package:design_system/src/extension/build_context_extension.dart';
import 'package:flutter/material.dart';

class DSHorizontalSpacerWidget extends StatelessWidget {
  const DSHorizontalSpacerWidget(this.factor, {super.key});

  final double factor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: context.space(factor: factor));
  }
}
