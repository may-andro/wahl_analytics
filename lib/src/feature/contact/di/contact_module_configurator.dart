import 'dart:async';

import 'package:core/core.dart';
import 'package:dependency_injection/dependency_injection.dart';
import 'package:feature_flag/feature_flag.dart';
import 'package:firebase/firebase.dart';
import 'package:wahl_analytics/src/feature/contact/data/data.dart';
import 'package:wahl_analytics/src/feature/contact/domain/domain.dart';
import 'package:wahl_analytics/src/feature/contact/presentation/contact_us/bloc/bloc.dart';
import 'package:wahl_analytics/src/feature/contact/presentation/route/route.dart';
import 'package:wahl_analytics/src/feature/validation/validation.dart';
import 'package:wahl_analytics/src/route/route.dart';

class ContactModuleConfigurator implements ModuleConfigurator {
  @override
  FutureOr<void> postDependenciesSetup(ServiceLocator serviceLocator) {
    serviceLocator
        .get<ModuleRouteController>()
        .register(ContactModuleRouteConfigurator());
  }

  @override
  FutureOr<void> preDependenciesSetup(ServiceLocator serviceLocator) {}

  @override
  FutureOr<void> registerDependencies(ServiceLocator serviceLocator) {
    serviceLocator.registerFactory<ContactRepository>(
      () => ContactRepositoryImpl(
        serviceLocator.get<AppLocale>(),
        serviceLocator.get<BuildConfig>(),
        serviceLocator.get<FbFirestoreController>(),
        BusinessContactMapper(),
        ContactUsMapper(),
      ),
    );

    serviceLocator.registerFactory(
      () => GetBusinessContactUseCase(serviceLocator.get<ContactRepository>()),
    );

    serviceLocator.registerFactory(
      () => SubmitContactUsApplicationUseCase(
        serviceLocator.get<ContactRepository>(),
      ),
    );

    serviceLocator.registerFactory(
      () => ContactUsBloc(
        serviceLocator.get<IsValidEmailUseCase>(),
        serviceLocator.get<IsValidNameUseCase>(),
        serviceLocator.get<IsValidMessageUseCase>(),
        serviceLocator.get<IsFeatureEnabledUseCase>(),
        serviceLocator.get<GetBusinessContactUseCase>(),
        serviceLocator.get<SubmitContactUsApplicationUseCase>(),
      ),
    );
  }
}
