import 'package:wahl_analytics/src/route/route.dart';

class CareerModuleRoute extends ModuleRoute {
  const CareerModuleRoute._(String name, String path)
    : super(name: name, path: path);

  static const CareerModuleRoute careersRequest = CareerModuleRoute._(
    'careers_request',
    '/careers_request',
  );

  static const CareerModuleRoute careerApplication = CareerModuleRoute._(
    'career_application',
    '/career_application',
  );
}
