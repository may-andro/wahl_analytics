import 'dart:async';

import 'package:core/core.dart';
import 'package:dependency_injection/dependency_injection.dart';
import 'package:feature_flag/src/data/data.dart';
import 'package:feature_flag/src/data/mapper/mapper.dart';
import 'package:feature_flag/src/domain/domain.dart';
import 'package:feature_flag/src/domain/repository/feature_flag_repository.dart';
import 'package:feature_flag/src/domain/use_case/init_feature_flags_use_case.dart';
import 'package:firebase/firebase.dart';
import 'package:flutter/foundation.dart';

class FeatureFlagModuleConfigurator implements ModuleConfigurator {
  FeatureFlagModuleConfigurator();

  @override
  FutureOr<void> postDependenciesSetup(ServiceLocator serviceLocator) async {
    if (!kIsWeb) {
      await serviceLocator.get<FeatureFlagCache>().initializeDB();
    }

    await serviceLocator.get<InitFeatureFlagsUseCase>().call();
  }

  @override
  FutureOr<void> preDependenciesSetup(ServiceLocator serviceLocator) {}

  @override
  FutureOr<void> registerDependencies(ServiceLocator serviceLocator) {
    // cache
    serviceLocator.registerSingleton(() => FeatureFlagCache());

    // repository
    final remoteFeatureFlagRepository = RemoteFeatureFlagRepository(
      serviceLocator.get<FbRemoteConfigController>(),
    );
    if (kIsWeb) {
      serviceLocator.registerSingleton<FeatureFlagRepository>(
        () => remoteFeatureFlagRepository,
      );
    } else {
      final cachedFeatureFlagRepository = CachedFeatureFlagRepository(
        remoteFeatureFlagRepository,
        serviceLocator.get<FeatureFlagCache>(),
        FeatureFlagMapper(),
        FeatureModelMapper(),
      );
      serviceLocator.registerSingleton<FeatureFlagRepository>(
        () => BuildFeatureFlagRepository(
          serviceLocator.get<BuildConfig>(),
          cachedFeatureFlagRepository,
          remoteFeatureFlagRepository,
        ),
      );
    }

    // use case
    serviceLocator.registerFactory(
      () => GetFeatureFlagsUseCase(
        serviceLocator.get<FeatureFlagRepository>(),
      ),
    );
    serviceLocator.registerFactory(
      () => InitFeatureFlagsUseCase(
        serviceLocator.get<FeatureFlagRepository>(),
      ),
    );
    serviceLocator.registerFactory(
      () => IsFeatureEnabledUseCase(
        serviceLocator.get<FeatureFlagRepository>(),
      ),
    );
    serviceLocator.registerFactory(
      () => ResetFeatureFlagsUseCase(
        serviceLocator.get<FeatureFlagRepository>(),
      ),
    );
    serviceLocator.registerFactory(
      () => UpdateFeatureFlagUseCase(
        serviceLocator.get<FeatureFlagRepository>(),
      ),
    );
  }
}
