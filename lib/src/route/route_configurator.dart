import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wahl_analytics/src/feature/error/error.dart';
import 'package:wahl_analytics/src/route/module_route_configurator.dart';

class RouteConfigurator {
  RouteConfigurator(
    this.moduleRouteConfigurator,
    this.navigationObservers,
  );

  final List<ModuleRouteConfigurator> moduleRouteConfigurator;
  final List<NavigatorObserver> navigationObservers;

  GoRouter get router {
    if (kIsWeb) {
      GoRouter.optionURLReflectsImperativeAPIs = true;
    }

    return GoRouter(
      initialLocation: '/',
      routes: moduleRouteConfigurator.expand((item) => item.routes).toList(),
      observers: navigationObservers,
      errorBuilder: (_, __) => const RouteNotFoundScreen(),
    );
  }
}
