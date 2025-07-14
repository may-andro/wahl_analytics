import 'package:collection/collection.dart';

enum BuildEnvironment {
  staging,
  prod;

  bool get isFirebaseEnabled => this == BuildEnvironment.prod;

  bool get isFeatureFlagCached => this == BuildEnvironment.staging;

  bool get isRemoteLoggingEnabled => this == BuildEnvironment.staging;

  bool get isSplashDescriptive => this == BuildEnvironment.staging;

  bool get isDevMenuEnabled => this == BuildEnvironment.staging;

  bool get debugShowCheckedModeBanner => this == BuildEnvironment.staging;

  static BuildEnvironment get buildEnvironment {
    const receivedEnv = String.fromEnvironment(
      'build_env',
      defaultValue: 'prod',
    );
    final foundEnv = BuildEnvironment.values.firstWhereOrNull(
      (value) => value.name == receivedEnv,
    );
    return foundEnv ?? BuildEnvironment.prod;
  }
}

class BuildConfig {
  BuildConfig({required this.buildEnvironment});

  final BuildEnvironment buildEnvironment;
}
