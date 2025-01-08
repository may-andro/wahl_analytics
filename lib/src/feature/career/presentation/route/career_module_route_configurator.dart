import 'package:wahl_analytics/src/feature/career/presentation/career_screen.dart';
import 'package:wahl_analytics/src/feature/career/presentation/route/career_module_route.dart';
import 'package:wahl_analytics/src/route/route.dart';

class CareerModuleRouteConfigurator implements ModuleRouteConfigurator {
  @override
  List<GoRoute> get routes {
    return [
      GoRoute(
        name: CareerModuleRoute.career.name,
        path: CareerModuleRoute.career.path,
        pageBuilder: (context, state) {
          return state.getCustomTransitionPage(const CareerScreen());
        },
      ),
    ];
  }
}
