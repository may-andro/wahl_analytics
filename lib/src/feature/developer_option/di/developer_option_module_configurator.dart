import 'dart:async';

import 'package:dependency_injection/dependency_injection.dart';
import 'package:feature_flag/feature_flag.dart';
import 'package:firebase/firebase.dart';
import 'package:flutter/foundation.dart';
import 'package:wahl_analytics/src/feature/developer_option/data/data.dart';
import 'package:wahl_analytics/src/feature/developer_option/domain/domain.dart';
import 'package:wahl_analytics/src/feature/developer_option/presentation/cache_playground/cache_playground.dart';
import 'package:wahl_analytics/src/feature/developer_option/presentation/dev_mode/dev_mode.dart';
import 'package:wahl_analytics/src/feature/developer_option/presentation/dev_mode_auth/bloc/dev_mode_auth_bloc.dart';
import 'package:wahl_analytics/src/feature/developer_option/presentation/feature_flag/feature_flag.dart';
import 'package:wahl_analytics/src/feature/developer_option/presentation/route/route.dart';
import 'package:wahl_analytics/src/feature/validation/domain/use_case/is_valid_verification_code_use_case.dart';
import 'package:wahl_analytics/src/route/route.dart';

class DeveloperOptionModuleConfigurator implements ModuleConfigurator {
  @override
  FutureOr<void> postDependenciesSetup(ServiceLocator serviceLocator) {
    if (!kIsWeb) {
      serviceLocator.get<DummyEntityCache>().initializeDB();
    }

    serviceLocator
        .get<ModuleRouteController>()
        .register(DeveloperOptionModuleRouteConfigurator());
  }

  @override
  FutureOr<void> preDependenciesSetup(ServiceLocator serviceLocator) {}

  @override
  FutureOr<void> registerDependencies(ServiceLocator serviceLocator) {
    serviceLocator.registerSingleton(() => DummyEntityCache());
    serviceLocator.registerSingleton(() => DevUserAuthenticatedCache());

    serviceLocator.registerFactory<DevModeAuthRepository>(
      () => DevModeAuthRepositoryImpl(
        serviceLocator.get<FbFirestoreController>(),
        serviceLocator.get<FbFunctionController>(),
        serviceLocator.get<DevUserAuthenticatedCache>(),
        AuthVerificationMapper(),
      ),
    );

    serviceLocator.registerFactory(
      () => RequestVerificationCodeUseCase(
        serviceLocator.get<DevModeAuthRepository>(),
      ),
    );

    serviceLocator.registerFactory(
      () => SubmitVerificationCodeUseCase(
        serviceLocator.get<DevModeAuthRepository>(),
      ),
    );

    serviceLocator.registerFactory(
      () => IsDevModeAuthenticatedUseCase(
        serviceLocator.get<DevModeAuthRepository>(),
      ),
    );

    serviceLocator.registerFactory(
      () => CacheDevModeAuthenticationUseCase(
        serviceLocator.get<DevModeAuthRepository>(),
      ),
    );

    serviceLocator.registerFactory(() => DevModeBloc());

    serviceLocator.registerFactory(
      () => DevModeAuthBloc(
        serviceLocator.get<RequestVerificationCodeUseCase>(),
        serviceLocator.get<SubmitVerificationCodeUseCase>(),
        serviceLocator.get<CacheDevModeAuthenticationUseCase>(),
        serviceLocator.get<IsValidVerificationCodeUseCase>(),
      ),
    );

    serviceLocator.registerFactory(
      () => FeatureFlagBloc(
        serviceLocator.get<GetFeatureFlagsUseCase>(),
        serviceLocator.get<UpdateFeatureFlagUseCase>(),
        serviceLocator.get<ResetFeatureFlagsUseCase>(),
      ),
    );

    serviceLocator.registerFactory(
      () => CachePlaygroundBloc(serviceLocator.get<DummyEntityCache>()),
    );
  }
}
