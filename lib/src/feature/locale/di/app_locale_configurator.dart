import 'package:core/core.dart';
import 'package:dependency_injection/dependency_injection.dart';
import 'package:wahl_analytics/src/feature/locale/data/data.dart';
import 'package:wahl_analytics/src/feature/locale/domain/domain.dart';

class AppLocaleConfigurator implements ModuleConfigurator {
  AppLocaleConfigurator(this._appLocale);

  final AppLocale _appLocale;

  @override
  void postDependenciesSetup(ServiceLocator serviceLocator) {}

  @override
  void preDependenciesSetup(ServiceLocator serviceLocator) {}

  @override
  void registerDependencies(ServiceLocator serviceLocator) {
    serviceLocator.registerSingleton(() => _appLocale);

    serviceLocator.registerSingleton(() => AppLocaleCache());

    serviceLocator.registerFactory(
      () => GetCachedAppLocaleUseCase(serviceLocator.get<AppLocaleCache>()),
    );
    serviceLocator.registerFactory(
      () => UpdateLocaleCacheUseCase(serviceLocator.get<AppLocaleCache>()),
    );
  }
}
