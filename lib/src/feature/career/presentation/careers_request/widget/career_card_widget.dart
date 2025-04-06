import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/l10n/l10n.dart';
import 'package:wahl_analytics/src/feature/career/domain/domain.dart';
import 'package:wahl_analytics/src/feature/career/presentation/careers_request/bloc/bloc.dart';

class CareerCardWidget extends StatelessWidget {
  const CareerCardWidget(this.career, {super.key});

  final CareerEntity career;

  @override
  Widget build(BuildContext context) {
    return DsCardWidget(
      backgroundColor: context.colorPalette.background.onPrimary,
      surfaceTintColor: context.colorPalette.neutral.transparent,
      elevation: context.dimen.elevationLevel3,
      radius: context.dimen.radiusLevel2,
      child: Padding(
        padding: EdgeInsets.all(context.space(factor: 2)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: context.colorPalette.prominent.primary.color,
                  radius: context.space(factor: context.isDesktop ? 2 : 3),
                  child: DSTextWidget(
                    career.name[0].toUpperCase(),
                    color: context.colorPalette.neutral.grey9,
                    style: context.typography.titleMedium,
                    softWrap: true,
                    maxLines: 1,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                ),
                const DSHorizontalSpacerWidget(2),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DSTextWidget(
                        career.name.capitalize,
                        color: context.colorPalette.neutral.grey1,
                        style: context.typography.bodyLarge,
                        softWrap: true,
                        maxLines: 1,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                      DSTextWidget(
                        career.role.toUpperCase(),
                        color: context.colorPalette.neutral.grey3,
                        style: context.typography.labelSmall,
                        softWrap: true,
                        maxLines: 1,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const DSVerticalSpacerWidget(2),
            DSIconTitleTileWidget(
              text: career.email.toLowerCase(),
              icon: Icons.email,
              iconSize: context.space(factor: context.isDesktop ? 1.5 : 2),
              textColor: context.colorPalette.neutral.grey4,
              style: context.typography.bodyMedium,
            ),
            const DSVerticalSpacerWidget(0.5),
            DSIconTitleTileWidget(
              text: career.country.capitalize,
              icon: Icons.location_city_rounded,
              iconSize: context.space(factor: context.isDesktop ? 1.5 : 2),
              textColor: context.colorPalette.neutral.grey4,
              style: context.typography.bodyMedium,
            ),
            const DSVerticalSpacerWidget(0.5),
            DSIconTitleTileWidget(
              text: career.uploadedAt.toFullDateWithoutTime,
              icon: Icons.date_range,
              iconSize: context.space(factor: context.isDesktop ? 1.5 : 2),
              textColor: context.colorPalette.neutral.grey4,
              style: context.typography.bodyMedium,
            ),
            const DSVerticalSpacerWidget(2),
            if (career.message.isNotEmpty) ...[
              DsCardWidget(
                backgroundColor: context.colorPalette.background.primary,
                radius: context.dimen.radiusLevel2,
                child: Padding(
                  padding: EdgeInsets.all(
                    context.space(factor: context.isDesktop ? 1 : 2),
                  ),
                  child: DSExpandableTextWidget(
                    career.message,
                    trimCollapsedText: context.localizations.showMore,
                    trimExpandedText: context.localizations.showLess,
                    style: context.typography.bodyMedium,
                    textColor: context.colorPalette.background.onPrimary,
                    collapsedTextColor: context.colorPalette.prominent.primary,
                    expandedTextColor: context.colorPalette.prominent.primary,
                  ),
                ),
              ),
              const DSVerticalSpacerWidget(2),
            ],
            Row(
              children: [
                DSButtonWidget(
                  label: context.localizations.deleteButton,
                  icon: Icons.delete_forever_rounded,
                  onPressed: () {
                    context.bloc.add(DeleteCareersRequestEvent(career: career));
                  },
                  variant: DSButtonVariant.error,
                  size: DSButtonSize.small,
                ),
                const DSHorizontalSpacerWidget(2),
                Expanded(
                  child: DSButtonWidget(
                    label: context.localizations.resumeFormFieldLabel,
                    icon: Icons.download,
                    onPressed: () {
                      context.bloc.add(OpenResumeEvent(career: career));
                    },
                    size: DSButtonSize.small,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
