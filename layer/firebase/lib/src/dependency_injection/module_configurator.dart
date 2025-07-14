import 'dart:async';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:dependency_injection/dependency_injection.dart';
import 'package:firebase/firebase.dart';
import 'package:firebase/src/app_check/fb_app_check_controller.dart';
import 'package:firebase/src/auth/fb_auth_controller.dart';
import 'package:firebase/src/firebase_options.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseModuleConfigurator implements ModuleConfigurator {
  FirebaseModuleConfigurator(
    this.isFirebaseEnabled,
  );

  final bool isFirebaseEnabled;

  @override
  FutureOr<void> postDependenciesSetup(ServiceLocator serviceLocator) async {
    // set up app check
    final appCheckController = serviceLocator.get<FbAppCheckController>();
    await appCheckController.initialiseAppCheck();

    // set up auth check
    final authController = serviceLocator.get<FbAuthController>();
    final userId = await authController.signInAndGetAnonymousUser();

    // set up crashlytics
    final crashlyticsController = serviceLocator.get<FbCrashlyticsController>();
    await crashlyticsController.setCrashlyticsEnabled(isFirebaseEnabled);
    await crashlyticsController.logMessage('App Started');

    // remote config
    final rcController = serviceLocator.get<FbRemoteConfigController>();
    await rcController.initialiseRemoteConfig();

    // analytics
    final analyticsController = serviceLocator.get<FbAnalyticsController>();
    await analyticsController.enableFirebaseAnalytics(isFirebaseEnabled);
    await analyticsController.sendUserEvent(userId);
  }

  @override
  FutureOr<void> preDependenciesSetup(ServiceLocator serviceLocator) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  FutureOr<void> registerDependencies(ServiceLocator serviceLocator) async {
    _injectAppCheck(serviceLocator);
    _injectAuth(serviceLocator);
    _injectCrashlytics(serviceLocator);
    await _injectRemoteConfig(serviceLocator);
    _injectAnalytics(serviceLocator);
    _injectFirestore(serviceLocator);
    _injectStorage(serviceLocator);
    _injectFunctions(serviceLocator);
  }

  void _injectAppCheck(ServiceLocator serviceLocator) {
    serviceLocator.registerSingleton(() => FirebaseAppCheck.instance);
    serviceLocator.registerFactory(
      () => FbAppCheckController(serviceLocator.get<FirebaseAppCheck>()),
    );
  }

  void _injectAuth(ServiceLocator serviceLocator) {
    serviceLocator.registerSingleton(() => FirebaseAuth.instance);
    serviceLocator.registerFactory(
      () => FbAuthController(serviceLocator.get<FirebaseAuth>()),
    );
  }

  void _injectCrashlytics(ServiceLocator serviceLocator) {
    serviceLocator.registerSingleton(() => FirebaseCrashlytics.instance);
    serviceLocator.registerFactory(
      () => FbCrashlyticsController(serviceLocator.get<FirebaseCrashlytics>()),
    );
  }

  Future<void> _injectRemoteConfig(ServiceLocator serviceLocator) async {
    serviceLocator.registerSingleton(() => FirebaseRemoteConfig.instance);
    serviceLocator.registerFactory(
      () => FbRemoteConfigController(
        serviceLocator.get<FirebaseRemoteConfig>(),
      ),
    );
  }

  void _injectAnalytics(ServiceLocator serviceLocator) {
    serviceLocator.registerSingleton(() => FirebaseAnalytics.instance);
    serviceLocator.registerFactory(
      () => FirebaseAnalyticsObserver(
        analytics: serviceLocator.get<FirebaseAnalytics>(),
      ),
    );
    serviceLocator.registerFactory(
      () => FbAnalyticsController(serviceLocator.get<FirebaseAnalytics>()),
    );
  }

  void _injectFirestore(ServiceLocator serviceLocator) {
    serviceLocator.registerSingleton(() => FirebaseFirestore.instance);
    serviceLocator.registerFactory(
      () => FbFirestoreController(serviceLocator.get<FirebaseFirestore>()),
    );
  }

  void _injectStorage(ServiceLocator serviceLocator) {
    serviceLocator.registerSingleton(() => FirebaseStorage.instance);
    serviceLocator.registerFactory(
      () => FbStorageController(serviceLocator.get<FirebaseStorage>()),
    );
  }

  void _injectFunctions(ServiceLocator serviceLocator) {
    serviceLocator.registerSingleton(
      () => FirebaseFunctions.instanceFor(region: 'europe-west3'),
    );
    serviceLocator.registerFactory(
      () => FbFunctionController(serviceLocator.get<FirebaseFunctions>()),
    );
  }
}
