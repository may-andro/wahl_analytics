import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/l10n/l10n.dart';

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
            context.localizations.contactInfoTitle,
            color: context.colorPalette.neutral.grey9,
            style: context.typography.titleLarge,
          ),
          SizedBox(height: context.space(factor: 0.5)),
          DSTextWidget(
            context.localizations.contactInfoDescription,
            color: context.colorPalette.neutral.grey7,
            style: context.typography.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
