import 'dart:async';

import 'package:dependency_injection/dependency_injection.dart';
import 'package:firebase/firebase.dart';
import 'package:log_reporter/src/log/composite_log_reporter.dart';
import 'package:log_reporter/src/log/firebase_log_reporter.dart';
import 'package:log_reporter/src/log/local_log_reporter.dart';
import 'package:log_reporter/src/log/log_reporter.dart';
import 'package:logger/logger.dart';

class LogReporterModuleConfigurator implements ModuleConfigurator {
  @override
  FutureOr<void> postDependenciesSetup(ServiceLocator serviceLocator) => null;

  @override
  FutureOr<void> preDependenciesSetup(ServiceLocator serviceLocator) => null;

  @override
  FutureOr<void> registerDependencies(ServiceLocator serviceLocator) {
    serviceLocator.registerSingleton(() => Logger());
    final localLogReporter = LocalLogReporter(
      serviceLocator.get<Logger>(),
    );

    final firebaseLogReporter = FirebaseLogReporter(
      serviceLocator.get<FbCrashlyticsController>(),
    );

    serviceLocator.registerSingleton<LogReporter>(
      () => CompositeLogReporter([
        firebaseLogReporter,
        localLogReporter,
      ]),
    );
  }
}
