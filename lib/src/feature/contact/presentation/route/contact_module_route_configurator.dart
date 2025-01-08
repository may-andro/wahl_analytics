import 'package:wahl_analytics/src/feature/contact/presentation/contact_us/contact_us.dart';
import 'package:wahl_analytics/src/feature/contact/presentation/route/contact_module_route.dart';
import 'package:wahl_analytics/src/route/route.dart';

class ContactModuleRouteConfigurator implements ModuleRouteConfigurator {
  @override
  List<GoRoute> get routes {
    return [
      GoRoute(
        name: ContactModuleRoute.contactUs.name,
        path: ContactModuleRoute.contactUs.path,
        pageBuilder: (context, state) {
          return state.getCustomTransitionPage(const ContactUsScreen());
        },
      ),
    ];
  }
}
