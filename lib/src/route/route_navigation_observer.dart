import 'package:flutter/material.dart';
import 'package:log_reporter/log_reporter.dart';

class RouteNavigationObserver extends NavigatorObserver {
  RouteNavigationObserver(this.logReporter);

  final LogReporter logReporter;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    logReporter.debug(
      'New route pushed: ${route.settings.name}, previous route was: ${previousRoute?.settings.name}',
      tag: 'RouteNavigationObserver',
    );
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    logReporter.debug(
      'Route popped: ${route.settings.name}, previous route was: ${previousRoute?.settings.name}',
      tag: 'RouteNavigationObserver',
    );
  }
}
