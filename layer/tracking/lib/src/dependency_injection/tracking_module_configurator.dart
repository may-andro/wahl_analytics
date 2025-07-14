import 'dart:async';

import 'package:dependency_injection/dependency_injection.dart';
import 'package:firebase/firebase.dart';
import 'package:tracking/src/model/model.dart';
import 'package:tracking/src/reporter/reporter.dart';

class TrackingModuleConfigurator implements ModuleConfigurator {
  TrackingModuleConfigurator(this.isFirebaseEnabled);

  final bool isFirebaseEnabled;

  @override
  FutureOr<void> postDependenciesSetup(ServiceLocator serviceLocator) {
    serviceLocator.get<TrackingReporter>().sendTrackingEvent(
      AppStartTracking(),
    );
  }

  @override
  FutureOr<void> preDependenciesSetup(ServiceLocator serviceLocator) => null;

  @override
  FutureOr<void> registerDependencies(ServiceLocator serviceLocator) {
    final firebaseTrackingReporter = FirebaseTrackingReporter(
      serviceLocator.get<FbAnalyticsController>(),
    );
    final localTrackingReporter = LocalTrackingReporter();
    serviceLocator.registerSingleton<TrackingReporter>(
      () => CompositeTrackingReporter([
        if (isFirebaseEnabled) firebaseTrackingReporter,
        localTrackingReporter,
      ]),
    );
  }
}
