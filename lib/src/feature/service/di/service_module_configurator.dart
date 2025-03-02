import 'dart:async';

import 'package:core/core.dart';
import 'package:dependency_injection/dependency_injection.dart';
import 'package:firebase/firebase.dart';
import 'package:wahl_analytics/src/feature/service/data/data.dart';
import 'package:wahl_analytics/src/feature/service/domain/domain.dart';
import 'package:wahl_analytics/src/feature/service/presentation/route/route.dart';
import 'package:wahl_analytics/src/feature/service/presentation/services_provided/bloc/bloc.dart';
import 'package:wahl_analytics/src/feature/service/presentation/services_update/bloc/bloc.dart';
import 'package:wahl_analytics/src/feature/validation/validation.dart';
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
    serviceLocator.registerSingleton<ServiceRepository>(
      () => ServiceRepositoryImpl(
        serviceLocator.get<AppLocale>(),
        serviceLocator.get<BuildConfig>(),
        serviceLocator.get<FbFirestoreController>(),
        BusinessServiceMapper(ServiceMapper()),
        AllLocaleBusinessServiceMapper(BusinessServiceMapper(ServiceMapper())),
      ),
    );

    serviceLocator.registerFactory(
      () => GetBusinessServiceUseCase(serviceLocator.get<ServiceRepository>()),
    );

    serviceLocator.registerFactory(
      () => GetAllLocaleBusinessServiceUseCase(
        serviceLocator.get<ServiceRepository>(),
      ),
    );

    serviceLocator.registerFactory(
      () => UpdateAllLocaleBusinessServiceUseCase(
        serviceLocator.get<ServiceRepository>(),
      ),
    );

    serviceLocator.registerFactory(() => ServicesProvidedBloc());

    serviceLocator.registerFactory(
      () => ServicesUpdateBloc(
        serviceLocator.get<AppLocale>(),
        serviceLocator.get<GetAllLocaleBusinessServiceUseCase>(),
        serviceLocator.get<UpdateAllLocaleBusinessServiceUseCase>(),
        serviceLocator.get<IsValidNameUseCase>(),
        serviceLocator.get<IsValidMessageUseCase>(),
      ),
    );

    serviceLocator.registerFactory(
      () => ServiceUpdateBloc(
        serviceLocator.get<IsValidNameUseCase>(),
        serviceLocator.get<IsValidShortDescriptionUseCase>(),
        serviceLocator.get<IsValidLongDescriptionUseCase>(),
      ),
    );
  }
}
