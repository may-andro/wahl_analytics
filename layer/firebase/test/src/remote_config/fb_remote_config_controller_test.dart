import 'package:firebase/src/remote_config/fb_remote_config_controller.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseRemoteConfig extends Mock implements FirebaseRemoteConfig {
  void mockGetValue(RemoteConfigValue expected) {
    when(() => getValue(any())).thenReturn(expected);
  }

  void mockGetAll(Map<String, RemoteConfigValue> expected) {
    when(getAll).thenReturn(expected);
  }

  void mockSetDefaults() {
    when(() => setDefaults(any())).thenAnswer((_) async => {});
  }

  void mockFetchAndActivate() {
    when(fetchAndActivate).thenAnswer((_) async => true);
  }
}

void main() {
  group(FbRemoteConfigController, () {
    late FbRemoteConfigController fbRemoteConfigController;

    late MockFirebaseRemoteConfig mockFirebaseRemoteConfig;

    setUp(() {
      mockFirebaseRemoteConfig = MockFirebaseRemoteConfig();

      fbRemoteConfigController = FbRemoteConfigController(
        mockFirebaseRemoteConfig,
      );
    });

    group('initialiseRemoteConfig', () {
      test(
        'should set defaults and fetch and activate remote configs',
        () async {
          mockFirebaseRemoteConfig.mockSetDefaults();
          mockFirebaseRemoteConfig.mockFetchAndActivate();

          await fbRemoteConfigController.initialiseRemoteConfig();

          verify(
            () => mockFirebaseRemoteConfig.setDefaults(
              RemoteConfigs.defaultConfigsMap,
            ),
          ).called(1);
          verify(() => mockFirebaseRemoteConfig.fetchAndActivate()).called(1);
        },
      );
    });

    group('getValueForKey', () {
      test('should return $RemoteConfigValue', () {
        final remoteConfig = RemoteConfigValue(null, ValueSource.valueStatic);
        mockFirebaseRemoteConfig.mockGetValue(remoteConfig);

        final result = fbRemoteConfigController.getValueForKey('');

        verify(() => mockFirebaseRemoteConfig.getValue('')).called(1);
        expect(result, remoteConfig);
      });
    });

    group('getAllConfigsValue', () {
      test('should return all config values', () {
        final Map<String, RemoteConfigValue> testConfigValues = {
          'feature_contact_us': RemoteConfigValue([], ValueSource.valueDefault),
        };
        mockFirebaseRemoteConfig.mockGetAll(testConfigValues);

        final result = fbRemoteConfigController.getAllConfigsValue();

        expect(result, testConfigValues);
        verify(mockFirebaseRemoteConfig.getAll).called(1);
      });
    });
  });
}
