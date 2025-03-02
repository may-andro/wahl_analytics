import 'package:wahl_analytics/src/route/route.dart';

class ServiceModuleRoute extends ModuleRoute {
  const ServiceModuleRoute._(String name, String path)
      : super(name: name, path: path);

  static const ServiceModuleRoute servicesProvided = ServiceModuleRoute._(
    'services_provided',
    '/services_provided',
  );

  static const ServiceModuleRoute servicesUpdate = ServiceModuleRoute._(
    'services_update',
    '/services_update',
  );
}
