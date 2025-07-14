import 'package:wahl_analytics/src/route/route.dart';

class DeveloperOptionModuleRoute extends ModuleRoute {
  const DeveloperOptionModuleRoute._(String name, String path)
    : super(name: name, path: path);

  static const DeveloperOptionModuleRoute devMode =
      DeveloperOptionModuleRoute._('dev_mode', '/dev_mode');

  static const DeveloperOptionModuleRoute featureFlag =
      DeveloperOptionModuleRoute._('feature_flag', '/feature_flag');

  static const DeveloperOptionModuleRoute cachePlayground =
      DeveloperOptionModuleRoute._('cache_playground', '/cache_playground');

  static const DeveloperOptionModuleRoute trackingLog =
      DeveloperOptionModuleRoute._('tracking_log', '/tracking_log');
}
