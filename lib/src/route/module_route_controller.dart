import 'package:error_reporter/error_reporter.dart';
import 'package:log_reporter/log_reporter.dart';
import 'package:wahl_analytics/src/route/module_route_configurator.dart';

class _ModuleRouteConfiguratorRegisteredException implements AppException {
  @override
  String toString() {
    return 'ModuleRouteConfiguratorRegisteredException: The ModuleRouteConfigurator is already registered';
  }
}

class ModuleRouteController {
  ModuleRouteController(this._logReporter);

  final LogReporter _logReporter;

  final List<ModuleRouteConfigurator> _routeConfigurators = [];

  void register(ModuleRouteConfigurator moduleRouteConfigurator) {
    if (_routeConfigurators.contains(moduleRouteConfigurator)) {
      _logReporter.error(
        'Duplicate ModuleRouteConfigurator found ${moduleRouteConfigurator.runtimeType}',
        stacktrace: StackTrace.current,
        error: _ModuleRouteConfiguratorRegisteredException(),
        tag: 'ModuleRouteController',
      );
    }
    _routeConfigurators.add(moduleRouteConfigurator);
  }

  List<ModuleRouteConfigurator> get registeredModuleRouteConfigurator {
    return _routeConfigurators;
  }
}
