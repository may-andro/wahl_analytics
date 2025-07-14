import 'dart:async';

import 'package:dependency_injection/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:log_reporter/log_reporter.dart';
import 'package:wahl_analytics/src/route/focus_clearing_route_observer.dart';
import 'package:wahl_analytics/src/route/module_route_controller.dart';
import 'package:wahl_analytics/src/route/route_navigation_observer.dart';

class RouteModuleConfigurator implements ModuleConfigurator {
  RouteModuleConfigurator();

  @override
  FutureOr<void> postDependenciesSetup(ServiceLocator serviceLocator) => null;

  @override
  FutureOr<void> preDependenciesSetup(ServiceLocator serviceLocator) => null;

  @override
  FutureOr<void> registerDependencies(ServiceLocator serviceLocator) {
    serviceLocator.registerSingleton(
      () => ModuleRouteController(serviceLocator.get<LogReporter>()),
    );

    serviceLocator.registerFactory(
      () => RouteNavigationObserver(serviceLocator.get<LogReporter>()),
    );

    serviceLocator.registerFactory(
      () => FocusClearingRouteObserver(FocusManager.instance),
    );
  }
}
