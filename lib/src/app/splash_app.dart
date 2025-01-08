import 'package:core/core.dart';
import 'package:dependency_injection/dependency_injection.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/l10n/l10n.dart';
import 'package:wahl_analytics/src/feature/locale/locale.dart';
import 'package:wahl_analytics/src/feature/splash/splash_screen.dart';

class SplashApp extends StatelessWidget {
  const SplashApp({
    required this.buildConfig,
    required this.moduleConfigurators,
    required this.onInitializationSuccessful,
    super.key,
  });

  final BuildConfig buildConfig;
  final List<ModuleConfigurator> moduleConfigurators;
  final void Function(DesignSystem) onInitializationSuccessful;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wahl Analytics',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          surface: const Color(0xFFF6F6F6),
          onSurface: const Color(0xFF212121),
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          surface: const Color(0xFF1E1E1E),
          onSurface: const Color(0xFFE0E0E0),
        ),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      localeResolutionCallback: (locale, supportedLocales) {
        final resolvedLocale =
            supportedLocales.contains(locale) ? locale : supportedLocales.first;
        final appLocale = AppLocale(resolvedLocale?.languageCode ?? 'en');
        moduleConfigurators.insert(0, AppLocaleConfigurator(appLocale));
        return resolvedLocale; // Return the resolved locale
      },
      home: SplashScreen(
        buildConfig: buildConfig,
        moduleConfigurators: moduleConfigurators,
        onInitializationSuccessful: onInitializationSuccessful,
      ),
    );
  }
}
