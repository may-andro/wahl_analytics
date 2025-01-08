import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class IntoWidget extends StatelessWidget {
  const IntoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.space(factor: 5)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DSTextWidget(
            'Our Services',
            color: context.colorPalette.neutral.grey9,
            style: context.typography.titleLarge,
          ),
          SizedBox(height: context.space(factor: 0.5)),
          DSTextWidget(
            'Transform your business with our Data Science and Business Analytics services. From trend analysis to interactive dashboards, we deliver insights that optimize operations and uncover new opportunities. Turn your data into clear, actionable strategies for success.',
            color: context.colorPalette.neutral.grey7,
            style: context.typography.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
