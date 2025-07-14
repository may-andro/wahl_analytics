import 'package:wahl_analytics/src/route/route.dart';

class ContactModuleRoute extends ModuleRoute {
  const ContactModuleRoute._(String name, String path)
    : super(name: name, path: path);

  static const ContactModuleRoute contactUs = ContactModuleRoute._(
    'contact_us',
    '/contact_us',
  );
}
