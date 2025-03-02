import 'dart:async';

import 'package:core/core.dart';
import 'package:dependency_injection/dependency_injection.dart';
import 'package:feature_flag/feature_flag.dart';
import 'package:wahl_analytics/src/feature/client/client.dart';
import 'package:wahl_analytics/src/feature/contact/contact.dart';
import 'package:wahl_analytics/src/feature/developer_option/developer_option.dart';
import 'package:wahl_analytics/src/feature/home/domain/domain.dart';
import 'package:wahl_analytics/src/feature/home/presentation/bloc/bloc.dart';
import 'package:wahl_analytics/src/feature/home/presentation/route/route.dart';
import 'package:wahl_analytics/src/feature/service/service.dart';
import 'package:wahl_analytics/src/feature/summary/summary.dart';
import 'package:wahl_analytics/src/feature/team/team.dart';
import 'package:wahl_analytics/src/route/route.dart';

class HomeModuleConfigurator implements ModuleConfigurator {
  @override
  FutureOr<void> postDependenciesSetup(ServiceLocator serviceLocator) {
    serviceLocator
        .get<ModuleRouteController>()
        .register(HomeModuleRouteConfigurator());
  }

  @override
  FutureOr<void> preDependenciesSetup(ServiceLocator serviceLocator) {}

  @override
  FutureOr<void> registerDependencies(ServiceLocator serviceLocator) {
    serviceLocator.registerFactory(
      () => GetHomeContentUseCase(
        serviceLocator.get<GetBusinessClientUseCase>(),
        serviceLocator.get<GetBusinessContactUseCase>(),
        serviceLocator.get<GetBusinessServiceUseCase>(),
        serviceLocator.get<GetBusinessSummaryUseCase>(),
        serviceLocator.get<GetBusinessTeamUseCase>(),
      ),
    );

    serviceLocator.registerFactory(
      () => HomeBloc(
        serviceLocator.get<GetHomeContentUseCase>(),
        serviceLocator.get<IsFeatureEnabledUseCase>(),
        serviceLocator.get<IsDevModeAuthenticatedUseCase>(),
        serviceLocator.get<BuildConfig>(),
      ),
    );
  }
}
