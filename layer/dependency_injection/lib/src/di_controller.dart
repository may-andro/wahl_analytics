import 'package:dependency_injection/src/configurator/module_configurator.dart';
import 'package:dependency_injection/src/model/di_setup_status.dart';
import 'package:dependency_injection/src/service_locator/get_it_service_locator.dart';
import 'package:dependency_injection/src/service_locator/service_locator.dart';

class DIController {
  factory DIController() {
    return DIController._internal(const GetItServiceLocator());
  }

  DIController._internal(this._serviceLocator);

  final ServiceLocator _serviceLocator;

  ServiceLocator get serviceLocator => _serviceLocator;

  Stream<DISetUpStatus> setUpDIGraph({
    required List<ModuleConfigurator> configurators,
  }) async* {
    yield DISetUpStatus.warmup;

    for (final configurator in configurators) {
      await configurator.preDependenciesSetup(_serviceLocator);
    }

    yield DISetUpStatus.fetch;

    for (final configurator in configurators) {
      await configurator.registerDependencies(_serviceLocator);
    }

    yield DISetUpStatus.register;

    for (final configurator in configurators) {
      await configurator.postDependenciesSetup(_serviceLocator);
    }

    yield DISetUpStatus.done;
  }
}
