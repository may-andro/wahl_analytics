import 'package:wahl_analytics/src/feature/developer_option/presentation/cache_playground/cache_playground.dart';
import 'package:wahl_analytics/src/feature/developer_option/presentation/dev_mode/dev_mode.dart';
import 'package:wahl_analytics/src/feature/developer_option/presentation/feature_flag/feature_flag.dart';
import 'package:wahl_analytics/src/feature/developer_option/presentation/route/developer_option_module_route.dart';
import 'package:wahl_analytics/src/route/route.dart';

class DeveloperOptionModuleRouteConfigurator
    implements ModuleRouteConfigurator {
  @override
  List<GoRoute> get routes {
    return [
      GoRoute(
        name: DeveloperOptionModuleRoute.devMode.name,
        path: DeveloperOptionModuleRoute.devMode.path,
        builder: (context, state) => const DevModeScreen(),
      ),
      GoRoute(
        name: DeveloperOptionModuleRoute.featureFlag.name,
        path: DeveloperOptionModuleRoute.featureFlag.path,
        builder: (context, state) => const FeatureFlagScreen(),
      ),
      GoRoute(
        name: DeveloperOptionModuleRoute.cachePlayground.name,
        path: DeveloperOptionModuleRoute.cachePlayground.path,
        builder: (context, state) => const DbCachePlaygroundScreen(),
      ),
    ];
  }
}
