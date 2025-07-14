import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/l10n/l10n.dart';
import 'package:wahl_analytics/src/dependency_injection/app_module_configurator.dart';
import 'package:wahl_analytics/src/feature/locale/presentation/bloc/bloc.dart';

class LocaleButtonWidget extends StatelessWidget {
  const LocaleButtonWidget({super.key, this.size, this.popupMenuYOffset = 5});

  final double? size;
  final double popupMenuYOffset;

  @override
  Widget build(BuildContext context) {
    const supportedLocales = AppLocalizations.supportedLocales;
    final buttonSize = size ?? 4;

    return BlocProvider(
      create: (_) =>
          appServiceLocator.get<LocaleBloc>()..add(const OnInitEvent()),
      child: BlocBuilder<LocaleBloc, LocaleState>(
        builder: (context, state) {
          return PopupMenuButton<Locale>(
            constraints: BoxConstraints.expand(
              width:
                  _getPopupItemTextStyle(context).getTextWidth(context, 'XXX') +
                  context.space(factor: 4) +
                  kDefaultFontSize * context.textScaleFactor,
              height:
                  _getPopupItemHeight(context) *
                  supportedLocales.length *
                  context.textScaleFactor,
            ),
            itemBuilder: _getPopupMenuItems,
            padding: EdgeInsets.zero,
            menuPadding: EdgeInsets.zero,
            splashRadius: context.dimen.radiusCircular.value,
            offset: Offset(0, context.space(factor: popupMenuYOffset)),
            color: context.colorPalette.brand.primary.color,
            elevation: context.dimen.elevationLevel2.value,
            tooltip: context.localizations.localeName,
            onSelected: (locale) {
              if (locale.appLocale == state.appLocale) return;
              context.bloc.add(UpdateLocaleEvent(locale));
            },
            onOpened: () {
              context.bloc.add(const LocaleClickEvent());
              context.bloc.add(const PopupVisibleEvent());
            },
            child: _ContentWidget(
              buttonSize: buttonSize,
              appLocale: state.appLocale,
            ),
          );
        },
      ),
    );
  }

  List<PopupMenuItem<Locale>> _getPopupMenuItems(BuildContext context) {
    return context.bloc.state.supportedLocales.map((locale) {
      return PopupMenuItem(
        value: locale,
        padding: EdgeInsets.zero,
        height: _getPopupItemHeight(context),
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
              style: _getPopupItemTextStyle(context),
            ),
          ],
        ),
      );
    }).toList();
  }

  DSTextStyle _getPopupItemTextStyle(BuildContext context) {
    return context.typography.bodyMedium;
  }

  double _getPopupItemHeight(BuildContext context) {
    return _getPopupItemTextStyle(context).getTextHeight(context, 1) +
        context.space(factor: 2);
  }
}

class _ContentWidget extends StatelessWidget {
  const _ContentWidget({required this.buttonSize, required this.appLocale});

  final double buttonSize;
  final AppLocale appLocale;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                appLocale.languageCode.toUpperCase(),
                color: context.colorPalette.brand.onPrimary,
                style: context.typography.labelSmall,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
