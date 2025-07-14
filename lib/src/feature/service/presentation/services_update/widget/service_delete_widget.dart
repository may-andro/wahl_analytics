import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/l10n/l10n.dart';
import 'package:wahl_analytics/src/feature/service/domain/domain.dart';
import 'package:wahl_analytics/src/route/route.dart';

class ServiceDeleteWidget extends StatelessWidget {
  const ServiceDeleteWidget({required this.service, super.key});

  final ServiceEntity service;

  static Future<bool?> showAsBottomSheet({
    required BuildContext context,
    required ServiceEntity service,
  }) {
    return showModalBottomSheet<bool>(
      context: context,
      backgroundColor: context.colorPalette.background.primary.color,
      builder: (context) => Padding(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).viewInsets.bottom,
          horizontal: context.space(factor: 5),
        ),
        child: ServiceDeleteWidget(service: service),
      ),
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
          context.localizations.deleteServiceTitle,
          color: context.colorPalette.neutral.grey9,
          style: context.typography.titleLarge,
        ),
        const DSVerticalSpacerWidget(1),
        DSTextWidget(
          context.localizations.deleteServiceSubTitle,
          color: context.colorPalette.neutral.grey7,
          style: context.typography.bodyLarge,
        ),
        const DSVerticalSpacerWidget(2),
        DsCardWidget(
          backgroundColor: context.colorPalette.backgroundSecondary.primary,
          surfaceTintColor: context.colorPalette.neutral.transparent,
          elevation: context.dimen.elevationLevel1,
          radius: context.dimen.radiusLevel2,
          child: Padding(
            padding: EdgeInsets.all(context.space(factor: 2)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  service.icon.customIconData,
                  color: context.colorPalette.prominent.primary.color,
                  size: context.space(
                    factor: context.isMobile
                        ? 4
                        : context.isTablet
                        ? 3
                        : 2,
                  ),
                ),
                const DSHorizontalSpacerWidget(3),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DSTextWidget(
                        service.title.toUpperCase(),
                        color: context.colorPalette.neutral.grey3,
                        style: context.typography.titleMedium,
                        softWrap: true,
                        maxLines: 1,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                      const DSVerticalSpacerWidget(0.5),
                      DSTextWidget(
                        service.shortDescription,
                        color: context.colorPalette.neutral.grey1,
                        style: context.typography.labelMedium,
                        softWrap: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const DSVerticalSpacerWidget(2),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            DSButtonWidget(
              key: const Key('deny_delete_button_widget'),
              label: context.localizations.cancelButton,
              onPressed: () => context.pop(false),
              variant: DSButtonVariant.secondary,
              size: DSButtonSize.small,
            ),
            const DSHorizontalSpacerWidget(2),
            DSButtonWidget(
              key: const Key('accept_delete_button_widget'),
              label: context.localizations.deleteButton,
              onPressed: () => context.pop(true),
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
