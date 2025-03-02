import 'package:wahl_analytics/src/feature/error/error.dart';
import 'package:wahl_analytics/src/feature/service/domain/domain.dart';
import 'package:wahl_analytics/src/feature/service/presentation/route/service_module_route.dart';
import 'package:wahl_analytics/src/feature/service/presentation/services_provided/services_provided.dart';
import 'package:wahl_analytics/src/feature/service/presentation/services_update/services_update.dart';
import 'package:wahl_analytics/src/route/route.dart';

class ServiceModuleRouteConfigurator implements ModuleRouteConfigurator {
  @override
  List<GoRoute> get routes {
    return [
      GoRoute(
        name: ServiceModuleRoute.servicesProvided.name,
        path: ServiceModuleRoute.servicesProvided.path,
        pageBuilder: (context, state) {
          final services = state.extra as List<ServiceEntity>?;
          if (services != null) {
            return state.getCustomTransitionPage(
              ServicesProvidedScreen(services: services),
            );
          }

          return state.getCustomTransitionPage(const RouteNotFoundScreen());
        },
      ),
      GoRoute(
        name: ServiceModuleRoute.servicesUpdate.name,
        path: ServiceModuleRoute.servicesUpdate.path,
        builder: (context, state) => const ServicesUpdateScreen(),
      ),
    ];
  }
}
