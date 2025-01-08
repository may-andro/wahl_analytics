import 'package:dependency_injection/dependency_injection.dart';
import 'package:wahl_analytics/src/app/run_app_initialization.dart';

Future<void> restartApp() async {
  final serviceLocator = DIController().serviceLocator;
  await serviceLocator.reset();
  await runAppWithInitialization();
}
