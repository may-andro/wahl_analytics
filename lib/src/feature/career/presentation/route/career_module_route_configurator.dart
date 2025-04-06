import 'package:wahl_analytics/src/feature/career/presentation/career_application/career_application_screen.dart';
import 'package:wahl_analytics/src/feature/career/presentation/careers_request/careers_request_screen.dart';
import 'package:wahl_analytics/src/feature/career/presentation/route/career_module_route.dart';
import 'package:wahl_analytics/src/route/route.dart';

class CareerModuleRouteConfigurator implements ModuleRouteConfigurator {
  @override
  List<GoRoute> get routes {
    return [
      GoRoute(
        name: CareerModuleRoute.careersRequest.name,
        path: CareerModuleRoute.careersRequest.path,
        pageBuilder: (context, state) {
          return state.getCustomTransitionPage(const CareersRequestScreen());
        },
      ),
      GoRoute(
        name: CareerModuleRoute.careerApplication.name,
        path: CareerModuleRoute.careerApplication.path,
        pageBuilder: (context, state) {
          return state.getCustomTransitionPage(const CareerApplicationScreen());
        },
      ),
    ];
  }
}
