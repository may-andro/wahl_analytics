import 'package:wahl_analytics/src/route/route.dart';

class CareerModuleRoute extends ModuleRoute {
  const CareerModuleRoute._(String name, String path)
      : super(name: name, path: path);

  static const CareerModuleRoute career = CareerModuleRoute._(
    'career',
    '/career',
  );
}
