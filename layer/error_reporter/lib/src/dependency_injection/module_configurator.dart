import 'dart:async';

import 'package:dependency_injection/dependency_injection.dart';
import 'package:error_reporter/src/blacklist_error/blacklist_error.dart';
import 'package:error_reporter/src/fatal_error/fatal_error.dart';
import 'package:error_reporter/src/reporter/crashlytics_error_reporter.dart';
import 'package:error_reporter/src/reporter/error_reporter.dart';
import 'package:error_reporter/src/reporter/logger_error_reporter.dart';
import 'package:firebase/firebase.dart';
import 'package:log_reporter/log_reporter.dart';

class ErrorReporterModuleConfigurator implements ModuleConfigurator {
  ErrorReporterModuleConfigurator(this.isFirebaseEnabled);

  final bool isFirebaseEnabled;

  @override
  FutureOr<void> postDependenciesSetup(ServiceLocator serviceLocator) async {
    await serviceLocator.get<ErrorReporter>().init();
  }

  @override
  FutureOr<void> preDependenciesSetup(ServiceLocator serviceLocator) {}

  @override
  FutureOr<void> registerDependencies(ServiceLocator serviceLocator) {
    // Blacklist errors
    serviceLocator.registerSingleton<BlacklistErrorController>(
      () => BlacklistErrorController(),
    );

    //Fatal Error Handler
    serviceLocator.registerSingleton<FatalErrorController>(
      () => FatalErrorController(),
    );

    // Error Reporter
    ErrorReporter errorReporter = LoggerErrorReporter(
      serviceLocator.get<FatalErrorController>(),
      serviceLocator.get<LogReporter>(),
    );
    if (isFirebaseEnabled) {
      errorReporter = CrashlyticsErrorReporter(
        serviceLocator.get<BlacklistErrorController>(),
        serviceLocator.get<FatalErrorController>(),
        serviceLocator.get<FbCrashlyticsController>(),
        serviceLocator.get<LogReporter>(),
      );
    }
    serviceLocator.registerSingleton<ErrorReporter>(() => errorReporter);
  }
}
