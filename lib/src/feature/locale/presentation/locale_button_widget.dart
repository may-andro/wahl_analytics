import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wahl_analytics/l10n/l10n.dart';
import 'package:wahl_analytics/src/app/run_app_initialization.dart';
import 'package:wahl_analytics/src/dependency_injection/app_module_configurator.dart';
import 'package:wahl_analytics/src/feature/locale/domain/domain.dart';

class LocaleButtonWidget extends StatelessWidget {
  const LocaleButtonWidget({
    super.key,
    this.size,
    this.popupMenuYOffset = 5,
  });

  final double? size;
  final double popupMenuYOffset;

  @override
  Widget build(BuildContext context) {
    const supportedLocales = AppLocalizations.supportedLocales;
    final buttonSize = size ?? 4;
    final popupItemTextStyle = context.typography.bodyMedium;
    final popupItemHeight =
        popupItemTextStyle.getTextHeight(context, 1) + context.space(factor: 2);

    return PopupMenuButton<Locale>(
      constraints: BoxConstraints.expand(
        width: popupItemTextStyle.getTextWidth(context, 'XXX') +
            context.space(factor: 4) +
            kDefaultFontSize * context.textScaleFactor,
        height:
            popupItemHeight * supportedLocales.length * context.textScaleFactor,
      ),
      itemBuilder: (context) => supportedLocales.map(
        (locale) {
          return PopupMenuItem(
            value: locale,
            padding: EdgeInsets.zero,
            height: popupItemHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.language_rounded,
                  color: context.colorPalette.brand.onPrimary.color,
                ),
                const DSHorizontalSpacerWidget(1),
                DSTextWidget(
                  locale.languageCode.toUpperCase(),
                  color: context.colorPalette.brand.onPrimary,
                  style: popupItemTextStyle,
                ),
              ],
            ),
          );
        },
      ).toList(),
      padding: EdgeInsets.zero,
      menuPadding: EdgeInsets.zero,
      splashRadius: context.dimen.radiusCircular.value,
      offset: Offset(0, context.space(factor: popupMenuYOffset)),
      color: context.colorPalette.brand.primary.color,
      elevation: context.dimen.elevationLevel2.value,
      tooltip: context.localizations.localeName,
      onSelected: (locale) {
        if (locale.languageCode == context.languageCode) return;

        appServiceLocator.get<UpdateLocaleCacheUseCase>().call(
              locale.languageCode,
            );
        Intl.defaultLocale = locale.languageCode;
        runAppWithInitialization();
      },
      child: SizedBox(
        height: context.space(factor: buttonSize),
        width: context.space(factor: buttonSize),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              child: Icon(
                Icons.language_rounded,
                size: context.space(factor: buttonSize * 0.8),
                color: context.colorPalette.brand.primary.color,
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(context.space(factor: 0.2)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(context.dimen.radiusCircular.value),
                  ),
                  border: Border.all(
                    color: context.colorPalette.brand.onPrimary.color,
                  ),
                  color: context.colorPalette.brand.primary.color,
                ),
                child: DSTextWidget(
                  context.languageCode.toUpperCase(),
                  color: context.colorPalette.brand.onPrimary,
                  style: context.typography.labelSmall,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
