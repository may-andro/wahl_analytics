import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/l10n/l10n.dart';
import 'package:wahl_analytics/src/feature/locale/locale.dart';
import 'package:wahl_analytics/src/route/route.dart';

class WahlAnalyticsApp extends StatelessWidget {
  const WahlAnalyticsApp({
    required this.buildConfig,
    required this.designSystem,
    required this.routeConfigurator,
    required this.appLocale,
    super.key,
  });

  final AppLocale appLocale;
  final BuildConfig buildConfig;
  final DesignSystem designSystem;
  final RouteConfigurator routeConfigurator;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Wahl Analytics',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: appLocale.locale,
      debugShowCheckedModeBanner:
          buildConfig.buildEnvironment.debugShowCheckedModeBanner,
      builder: (context, child) {
        return DSThemeBuilderWidget(
          brightness: context.platformBrightness,
          designSystem: designSystem,
          child: SystemLocaleListenerWidget(
            child: child ?? const SizedBox.shrink(),
          ),
        );
      },
      routerConfig: routeConfigurator.router,
    );
  }
}
