import 'package:core/core.dart';
import 'package:dependency_injection/dependency_injection.dart';
import 'package:design_system/design_system.dart';
import 'package:firebase/firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:log_reporter/log_reporter.dart';
import 'package:tracking/tracking.dart';
import 'package:wahl_analytics/src/app/splash_app.dart';
import 'package:wahl_analytics/src/app/wahl_analytics_app.dart';
import 'package:wahl_analytics/src/dependency_injection/module_configurators.dart';
import 'package:wahl_analytics/src/feature/locale/locale.dart';
import 'package:wahl_analytics/src/route/route.dart';
import 'package:wahl_analytics/src/utility/app_bloc_observer.dart';

Future<void> runAppWithInitialization() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle());

  final buildConfig = BuildConfig(
    buildEnvironment: BuildEnvironment.buildEnvironment,
  );
  final moduleConfigurators = getModuleConfigurators(buildConfig);

  FlutterNativeSplash.remove();

  runApp(
    SplashApp(
      buildConfig: buildConfig,
      moduleConfigurators: moduleConfigurators,
      onInitializationSuccessful: _runMainApp,
    ),
  );
}

void _runMainApp(DesignSystem designSystem) {
  final serviceLocator = DIController().serviceLocator;

  final appLocale = serviceLocator.get<AppLocale>();
  _sendAppStartEvent(appLocale);
  Bloc.observer = serviceLocator.get<AppBlocObserver>();

  runApp(
    LocaleListenerWidget(
      appLocale: appLocale,
      builder: (context, appLocale) {
        return WahlAnalyticsApp(
          appLocale: appLocale,
          buildConfig: serviceLocator.get<BuildConfig>(),
          designSystem: designSystem,
          routeConfigurator: _routeConfigurator,
        );
      },
    ),
  );
}

RouteConfigurator get _routeConfigurator {
  final serviceLocator = DIController().serviceLocator;
  final moduleRouteConfigurator = serviceLocator.get<ModuleRouteController>();
  final navigationObservers = [
    serviceLocator.get<FirebaseAnalyticsObserver>(),
    serviceLocator.get<RouteNavigationObserver>(),
    serviceLocator.get<FocusClearingRouteObserver>(),
    routeObserver,
  ];
  final routeConfigurator = RouteConfigurator(
    moduleRouteConfigurator.registeredModuleRouteConfigurator,
    navigationObservers,
  );
  return routeConfigurator;
}

void _sendAppStartEvent(AppLocale appLocale) {
  final serviceLocator = DIController().serviceLocator;

  final logReporter = serviceLocator.get<LogReporter>();
  logReporter.debug(
    'Project is setup in locale: ${appLocale.locale}',
    tag: 'runAppWithInitialization',
  );

  final trackingReporter = serviceLocator.get<TrackingReporter>();
  trackingReporter.sendTrackingEvent(AppInitializationFinishedTracking());
}
