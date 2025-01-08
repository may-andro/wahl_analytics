import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/l10n/l10n.dart';
import 'package:wahl_analytics/src/feature/locale/presentation/locale_provider_widget.dart';
import 'package:wahl_analytics/src/route/route.dart';

class WahlAnalyticsApp extends StatelessWidget {
  const WahlAnalyticsApp({
    required this.buildConfig,
    required this.designSystem,
    required this.routeConfigurator,
    super.key,
  });

  final BuildConfig buildConfig;
  final DesignSystem designSystem;
  final RouteConfigurator routeConfigurator;

  @override
  Widget build(BuildContext context) {
    final locale = LocaleProviderWidget.of(context);
    return MaterialApp.router(
      title: 'Wahl Analytics',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: locale,
      debugShowCheckedModeBanner:
          buildConfig.buildEnvironment.debugShowCheckedModeBanner,
      builder: (context, child) {
        return DSThemeBuilderWidget(
          brightness: context.platformBrightness,
          designSystem: designSystem,
          child: child ?? const SizedBox.shrink(),
        );
      },
      routerConfig: routeConfigurator.router,
    );
  }
}
