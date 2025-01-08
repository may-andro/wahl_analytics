import 'dart:async';

import 'package:core/core.dart';
import 'package:dependency_injection/dependency_injection.dart';
import 'package:firebase/firebase.dart';
import 'package:wahl_analytics/src/feature/service/data/data.dart';
import 'package:wahl_analytics/src/feature/team/data/data.dart';
import 'package:wahl_analytics/src/feature/team/domain/domain.dart';

class TeamModuleConfigurator implements ModuleConfigurator {
  @override
  FutureOr<void> postDependenciesSetup(ServiceLocator serviceLocator) {}

  @override
  FutureOr<void> preDependenciesSetup(ServiceLocator serviceLocator) {}

  @override
  FutureOr<void> registerDependencies(ServiceLocator serviceLocator) {
    serviceLocator.registerFactory<TeamRepository>(
      () => TeamRepositoryImpl(
        serviceLocator.get<AppLocale>(),
        serviceLocator.get<BuildConfig>(),
        serviceLocator.get<FbFirestoreController>(),
        BusinessTeamMapper(TeamMemberMapper(ServiceMapper())),
      ),
    );

    serviceLocator.registerFactory(
      () => GetBusinessTeamUseCase(serviceLocator.get<TeamRepository>()),
    );
  }
}
