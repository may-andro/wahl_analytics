import 'package:core/core.dart';
import 'package:dependency_injection/dependency_injection.dart';
import 'package:tracking/tracking.dart';
import 'package:wahl_analytics/src/feature/locale/data/data.dart';
import 'package:wahl_analytics/src/feature/locale/domain/domain.dart';
import 'package:wahl_analytics/src/feature/locale/presentation/bloc/bloc.dart';
import 'package:wahl_analytics/src/feature/locale/presentation/tracking/tracking.dart';

class LocaleModuleConfigurator implements ModuleConfigurator {
  LocaleModuleConfigurator();

  @override
  Future<void> postDependenciesSetup(ServiceLocator serviceLocator) async {
    final appLocale = serviceLocator.get<AppLocale>();
    final appLocaleEither = await serviceLocator.get<GetLocaleUseCase>().call();

    if (appLocaleEither.isRight) {
      final cachedAppLocale = appLocaleEither.right;
      if (appLocale != cachedAppLocale) {
        serviceLocator.get<UpdateLocaleUseCase>().call(cachedAppLocale);
      }
    }
  }

  @override
  void preDependenciesSetup(ServiceLocator serviceLocator) {}

  @override
  void registerDependencies(ServiceLocator serviceLocator) {
    serviceLocator.registerSingleton(() => AppLocaleCache());

    serviceLocator.registerSingleton<LocaleRepository>(
      () => LocaleRepositoryImpl(
        serviceLocator.get<AppLocale>(),
        serviceLocator.get<AppLocaleCache>(),
      ),
    );

    serviceLocator.registerFactory(
      () => GetLocaleUseCase(serviceLocator.get<LocaleRepository>()),
    );
    serviceLocator.registerFactory(
      () => UpdateLocaleUseCase(serviceLocator.get<LocaleRepository>()),
    );
    serviceLocator.registerFactory(
      () => GetLocaleStreamUseCase(serviceLocator.get<LocaleRepository>()),
    );

    serviceLocator.registerFactory(
      () => LocaleTrackingDelegate(serviceLocator.get<TrackingReporter>()),
    );

    serviceLocator.registerFactory(
      () => LocaleBloc(
        serviceLocator.get<AppLocale>(),
        serviceLocator.get<GetLocaleUseCase>(),
        serviceLocator.get<UpdateLocaleUseCase>(),
        serviceLocator.get<LocaleTrackingDelegate>(),
      ),
    );
  }
}
