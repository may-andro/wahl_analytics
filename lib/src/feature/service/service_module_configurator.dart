import 'dart:async';

import 'package:core/core.dart';
import 'package:dependency_injection/dependency_injection.dart';
import 'package:firebase/firebase.dart';
import 'package:wahl_analytics/src/feature/service/data/data.dart';
import 'package:wahl_analytics/src/feature/service/domain/domain.dart';
import 'package:wahl_analytics/src/feature/service/presentation/route/route.dart';
import 'package:wahl_analytics/src/feature/service/presentation/services_provided/bloc/bloc.dart';
import 'package:wahl_analytics/src/route/route.dart';

class ServiceModuleConfigurator implements ModuleConfigurator {
  @override
  FutureOr<void> postDependenciesSetup(ServiceLocator serviceLocator) {
    serviceLocator
        .get<ModuleRouteController>()
        .register(ServiceModuleRouteConfigurator());
  }

  @override
  FutureOr<void> preDependenciesSetup(ServiceLocator serviceLocator) {}

  @override
  FutureOr<void> registerDependencies(ServiceLocator serviceLocator) {
    serviceLocator.registerFactory<ServiceRepository>(
      () => ServiceRepositoryImpl(
        serviceLocator.get<AppLocale>(),
        serviceLocator.get<BuildConfig>(),
        serviceLocator.get<FbFirestoreController>(),
        BusinessServiceMapper(ServiceMapper()),
      ),
    );

    serviceLocator.registerFactory(
      () => GetBusinessServiceUseCase(serviceLocator.get<ServiceRepository>()),
    );

    serviceLocator.registerFactory(() => ServicesProvidedBloc());
  }
}
