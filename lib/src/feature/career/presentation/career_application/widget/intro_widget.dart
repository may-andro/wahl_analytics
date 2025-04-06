import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/l10n/extension/l10n_extension.dart';

class IntoWidget extends StatelessWidget {
  const IntoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const DSVerticalSpacerWidget(2),
        DSTextWidget(
          context.localizations.careerPageIntroLabel.toUpperCase(),
          color: context.colorPalette.neutral.grey3,
          style: context.typography.bodySmall,
        ),
        const DSVerticalSpacerWidget(0.5),
        DSTextWidget(
          context.localizations.careerPageIntroTitle,
          color: context.colorPalette.neutral.grey1,
          style: context.typography.headlineMedium,
        ),
        const DSVerticalSpacerWidget(1.5),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.space(factor: 2)),
          child: DSTextWidget(
            context.localizations.careerPageIntroDescription,
            color: context.colorPalette.neutral.grey3,
            style: context.typography.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ),
        const DSVerticalSpacerWidget(5),
      ],
    );
  }
}
