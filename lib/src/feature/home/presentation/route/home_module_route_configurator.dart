import 'package:wahl_analytics/src/feature/home/presentation/home_screen.dart';
import 'package:wahl_analytics/src/feature/home/presentation/route/home_module_route.dart';
import 'package:wahl_analytics/src/route/route.dart';

class HomeModuleRouteConfigurator implements ModuleRouteConfigurator {
  @override
  List<GoRoute> get routes {
    return [
      GoRoute(
        name: HomeModuleRoute.home.name,
        path: HomeModuleRoute.home.path,
        builder: (context, state) => const HomeScreen(),
      ),
    ];
  }
}
