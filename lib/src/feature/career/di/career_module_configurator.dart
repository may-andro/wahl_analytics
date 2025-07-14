import 'dart:async';

import 'package:core/core.dart';
import 'package:dependency_injection/dependency_injection.dart';
import 'package:firebase/firebase.dart';
import 'package:tracking/tracking.dart';
import 'package:wahl_analytics/src/feature/career/data/data.dart';
import 'package:wahl_analytics/src/feature/career/domain/domain.dart';
import 'package:wahl_analytics/src/feature/career/presentation/career_application/bloc/bloc.dart';
import 'package:wahl_analytics/src/feature/career/presentation/career_application/tracking/tracking.dart';
import 'package:wahl_analytics/src/feature/career/presentation/careers_request/bloc/bloc.dart';
import 'package:wahl_analytics/src/feature/career/presentation/careers_request/tracking/tracking.dart';
import 'package:wahl_analytics/src/feature/career/presentation/route/route.dart';
import 'package:wahl_analytics/src/feature/file_picker/file_picker.dart';
import 'package:wahl_analytics/src/feature/url_handler/url_handler.dart';
import 'package:wahl_analytics/src/feature/validation/validation.dart';
import 'package:wahl_analytics/src/route/route.dart';

class CareerModuleConfigurator implements ModuleConfigurator {
  @override
  FutureOr<void> postDependenciesSetup(ServiceLocator serviceLocator) {
    serviceLocator.get<ModuleRouteController>().register(
      CareerModuleRouteConfigurator(),
    );
  }

  @override
  FutureOr<void> preDependenciesSetup(ServiceLocator serviceLocator) {}

  @override
  FutureOr<void> registerDependencies(ServiceLocator serviceLocator) {
    serviceLocator.registerSingleton<CareerRepository>(
      () => CareerRepositoryImpl(
        serviceLocator.get<BuildConfig>(),
        serviceLocator.get<FbStorageController>(),
        serviceLocator.get<FbFirestoreController>(),
        CareerApplicationMapper(),
        CareerMapper(),
      ),
    );

    serviceLocator.registerFactory(
      () => SubmitCareerApplicationUseCase(
        serviceLocator.get<CareerRepository>(),
      ),
    );

    serviceLocator.registerFactory(
      () => GetCareersRequestUseCase(serviceLocator.get<CareerRepository>()),
    );

    serviceLocator.registerFactory(
      () => DeleteCareerRequestUseCase(serviceLocator.get<CareerRepository>()),
    );

    serviceLocator.registerFactory(
      () => DownloadResumeUseCase(serviceLocator.get<FbStorageController>()),
    );

    serviceLocator.registerFactory(
      () => CareerApplicationTrackingDelegate(
        serviceLocator.get<TrackingReporter>(),
      ),
    );

    serviceLocator.registerFactory(
      () => CareerApplicationBloc(
        serviceLocator.get<BuildConfig>(),
        serviceLocator.get<IsValidCountryUseCase>(),
        serviceLocator.get<IsValidEmailUseCase>(),
        serviceLocator.get<IsValidNameUseCase>(),
        serviceLocator.get<IsValidRoleUseCase>(),
        serviceLocator.get<IsValidMessageUseCase>(),
        serviceLocator.get<FilePickerUseCase>(),
        serviceLocator.get<SubmitCareerApplicationUseCase>(),
        serviceLocator.get<CareerApplicationTrackingDelegate>(),
      ),
    );

    serviceLocator.registerFactory(
      () => CareersRequestTrackingDelegate(
        const CareersRequestTrackingArea(),
        serviceLocator.get<TrackingReporter>(),
      ),
    );

    serviceLocator.registerFactory(
      () => CareersRequestBloc(
        serviceLocator.get<GetCareersRequestUseCase>(),
        serviceLocator.get<DeleteCareerRequestUseCase>(),
        serviceLocator.get<DownloadResumeUseCase>(),
        serviceLocator.get<FileOpenerUseCase>(),
        serviceLocator.get<OpenExternalUrlUseCase>(),
        serviceLocator.get<CareersRequestTrackingDelegate>(),
      ),
    );
  }
}
