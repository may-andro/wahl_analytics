import 'package:core/src/model/build_config.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BuildEnvironment', () {
    group('isFirebaseEnabled', () {
      test('should return true only when env is prod', () {
        expect(BuildEnvironment.prod.isFirebaseEnabled, isTrue);
        expect(BuildEnvironment.staging.isFirebaseEnabled, isFalse);
      });
    });

    group('isFeatureFlagCached', () {
      test('should return true only when env is staging', () {
        expect(BuildEnvironment.staging.isFeatureFlagCached, isTrue);
        expect(BuildEnvironment.prod.isFeatureFlagCached, isFalse);
      });
    });

    group('isRemoteLoggingEnabled', () {
      test('should return true only when env is staging', () {
        expect(BuildEnvironment.staging.isRemoteLoggingEnabled, isTrue);
        expect(BuildEnvironment.prod.isRemoteLoggingEnabled, isFalse);
      });
    });

    group('isSplashDescriptive', () {
      test('should return true only when env is staging', () {
        expect(BuildEnvironment.staging.isSplashDescriptive, isTrue);
        expect(BuildEnvironment.prod.isSplashDescriptive, isFalse);
      });
    });

    group('isDevMenuEnabled', () {
      test('should return true only when env is staging', () {
        expect(BuildEnvironment.staging.isDevMenuEnabled, isTrue);
        expect(BuildEnvironment.prod.isDevMenuEnabled, isFalse);
      });
    });

    group('debugShowCheckedModeBanner', () {
      test('should return true only when env is staging', () {
        expect(BuildEnvironment.staging.debugShowCheckedModeBanner, isTrue);
        expect(BuildEnvironment.prod.debugShowCheckedModeBanner, isFalse);
      });
    });
  });
}
