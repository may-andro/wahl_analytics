import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/l10n/l10n.dart';
import 'package:wahl_analytics/src/feature/home/home.dart';
import 'package:wahl_analytics/src/route/route.dart';

class UpdateMessageWidget extends StatelessWidget {
  const UpdateMessageWidget({
    required this.isUpdatedSuccessfully,
    required this.locale,
    super.key,
  });

  final bool isUpdatedSuccessfully;
  final String locale;

  static Future<bool?> showAsBottomSheet({
    required BuildContext context,
    required bool isUpdatedSuccessfully,
    required String locale,
  }) {
    return showModalBottomSheet<bool>(
      context: context,
      backgroundColor: context.colorPalette.background.primary.color,
      builder: (context) => Padding(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).viewInsets.bottom,
          horizontal: context.space(factor: 5),
        ),
        child: UpdateMessageWidget(
          isUpdatedSuccessfully: isUpdatedSuccessfully,
          locale: locale,
        ),
      ),
    );
  }

  static Future<bool?> showAsDialog({
    required BuildContext context,
    required bool isUpdatedSuccessfully,
    required String locale,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: context.colorPalette.background.primary.color,
          content: Padding(
            padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).viewInsets.bottom,
              horizontal: context.space(factor: 5),
            ),
            child: UpdateMessageWidget(
              isUpdatedSuccessfully: isUpdatedSuccessfully,
              locale: locale,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const DSVerticalSpacerWidget(5),
        DSTextWidget(
          isUpdatedSuccessfully
              ? context.localizations.dataUpdateSuccess
              : context.localizations.dataUpdateFailure,
          color: context.colorPalette.neutral.grey9,
          style: context.typography.titleLarge,
        ),
        const DSVerticalSpacerWidget(1),
        DSTextWidget(
          isUpdatedSuccessfully
              ? context.localizations.serviceUpdatedSuccessMessage(locale)
              : context.localizations.serviceUpdatedFailureMessage(locale),
          color: context.colorPalette.neutral.grey7,
          style: context.typography.bodyLarge,
        ),
        const DSVerticalSpacerWidget(2),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            DSButtonWidget(
              key: const Key('close_button_widget'),
              label: context.localizations.closeButton,
              onPressed: () => context.pop(false),
              variant: DSButtonVariant.secondary,
              size: DSButtonSize.small,
            ),
            const DSHorizontalSpacerWidget(2),
            DSButtonWidget(
              key: const Key('go_home_button_widget'),
              label: context.localizations.goToHomeButton,
              onPressed: () {
                context.popUntil(HomeModuleRoute.home.name);
              },
              variant: DSButtonVariant.prominent,
              size: DSButtonSize.small,
            ),
          ],
        ),
        const DSVerticalSpacerWidget(5),
      ],
    );
  }
}
