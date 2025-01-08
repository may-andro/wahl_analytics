import 'dart:convert';

import 'package:feature_flag/feature_flag.dart';
import 'package:feature_flag/src/data/data.dart';
import 'package:firebase/firebase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFbRemoteConfigController extends Mock
    implements FbRemoteConfigController {
  void mockGetAllConfigsValue(Map<String, RemoteConfigValue> expected) {
    when(getAllConfigsValue).thenReturn(expected);
  }
}

void main() {
  group('RemoteFeatureFlagRepository', () {
    late RemoteFeatureFlagRepository repository;

    late MockFbRemoteConfigController mockFbRemoteConfigController;

    setUp(() {
      mockFbRemoteConfigController = MockFbRemoteConfigController();

      repository = RemoteFeatureFlagRepository(mockFbRemoteConfigController);
    });

    group('initFeatureFlags', () {
      test('should cache FeatureFlags when firebase return a valid list', () {
        final configs = {
          'contact_us_home_fab': RemoteConfigValue(
            utf8.encode('true'),
            ValueSource.valueStatic,
          ),
          'language_switcher': RemoteConfigValue(
            utf8.encode('false'),
            ValueSource.valueRemote,
          ),
        };
        mockFbRemoteConfigController.mockGetAllConfigsValue(configs);

        repository.initFeatureFlags();

        expect(
          repository.getFeatureFlags(),
          const [
            FeatureFlag(Feature.contactUsHomeFab, true),
            FeatureFlag(Feature.languageSwitcher, false),
          ],
        );
      });

      test(
          'should cache only bool FeatureFlags '
          'when firebase return a valid list', () {
        final configs = {
          'contact_us_home_fab': RemoteConfigValue(
            utf8.encode('false'),
            ValueSource.valueStatic,
          ),
          'feature_string': RemoteConfigValue(
            utf8.encode('abc'),
            ValueSource.valueRemote,
          ),
        };
        mockFbRemoteConfigController.mockGetAllConfigsValue(configs);

        repository.initFeatureFlags();

        expect(
          repository.getFeatureFlags(),
          const [FeatureFlag(Feature.contactUsHomeFab, false)],
        );
      });

      test(
          'should cache null values as false '
          'when firebase return a valid list', () {
        final configs = {
          'contact_us_home_fab': RemoteConfigValue(
            null,
            ValueSource.valueStatic,
          ),
          'feature_string': RemoteConfigValue(
            utf8.encode('abc'),
            ValueSource.valueRemote,
          ),
        };
        mockFbRemoteConfigController.mockGetAllConfigsValue(configs);

        repository.initFeatureFlags();

        expect(
          repository.getFeatureFlags(),
          const [FeatureFlag(Feature.contactUsHomeFab, false)],
        );
      });
    });

    group('getFeatureFlags', () {
      test(
          'should return empty list '
          'when initFeatureFlags is not called', () {
        final result = repository.getFeatureFlags();

        expect(result.isEmpty, isTrue);
      });

      test('should return list when cache is available', () {
        final configs = {
          'contact_us_home_fab': RemoteConfigValue(
            utf8.encode('false'),
            ValueSource.valueStatic,
          ),
          'language_switcher': RemoteConfigValue(
            utf8.encode('true'),
            ValueSource.valueRemote,
          ),
        };
        mockFbRemoteConfigController.mockGetAllConfigsValue(configs);

        repository.initFeatureFlags();
        final result = repository.getFeatureFlags();

        expect(result.isEmpty, isFalse);
        expect(
          result,
          const [
            FeatureFlag(Feature.contactUsHomeFab, false),
            FeatureFlag(Feature.languageSwitcher, true),
          ],
        );
      });

      test('should skip invalid keys', () {
        final configs = {
          'contact_us_home_fab': RemoteConfigValue(
            utf8.encode('false'),
            ValueSource.valueStatic,
          ),
          'language_switcher': RemoteConfigValue(
            utf8.encode('true'),
            ValueSource.valueRemote,
          ),
          'feature_string': RemoteConfigValue(
            utf8.encode('true'),
            ValueSource.valueRemote,
          ),
        };
        mockFbRemoteConfigController.mockGetAllConfigsValue(configs);

        repository.initFeatureFlags();
        final result = repository.getFeatureFlags();

        expect(result.isEmpty, isFalse);
        expect(
          result,
          const [
            FeatureFlag(Feature.contactUsHomeFab, false),
            FeatureFlag(Feature.languageSwitcher, true),
          ],
        );
      });
    });

    group('isFeatureEnabled', () {
      test('should return Feature value when available', () {
        final configs = {
          'contact_us_home_fab': RemoteConfigValue(
            utf8.encode('false'),
            ValueSource.valueStatic,
          ),
          'language_switcher': RemoteConfigValue(
            utf8.encode('true'),
            ValueSource.valueRemote,
          ),
          'feature_string': RemoteConfigValue(
            utf8.encode('true'),
            ValueSource.valueRemote,
          ),
        };
        mockFbRemoteConfigController.mockGetAllConfigsValue(configs);

        repository.initFeatureFlags();

        expect(repository.isFeatureEnabled(Feature.contactUsHomeFab), isFalse);
        expect(repository.isFeatureEnabled(Feature.languageSwitcher), isTrue);
      });

      test('should return false value when Feature is not found', () {
        final configs = {
          'contact_us_home_fab': RemoteConfigValue(
            utf8.encode('true'),
            ValueSource.valueStatic,
          ),
        };
        mockFbRemoteConfigController.mockGetAllConfigsValue(configs);

        repository.initFeatureFlags();

        expect(repository.isFeatureEnabled(Feature.contactUsHomeFab), isTrue);
        expect(repository.isFeatureEnabled(Feature.languageSwitcher), isFalse);
      });
    });

    group('reset', () {
      test('should reset the list and fetch new list', () {
        final configs = {
          'contact_us_home_fab': RemoteConfigValue(
            utf8.encode('true'),
            ValueSource.valueStatic,
          ),
          'language_switcher': RemoteConfigValue(
            utf8.encode('false'),
            ValueSource.valueRemote,
          ),
        };
        mockFbRemoteConfigController.mockGetAllConfigsValue(configs);

        repository.initFeatureFlags();

        expect(
          repository.getFeatureFlags(),
          const [
            FeatureFlag(Feature.contactUsHomeFab, true),
            FeatureFlag(Feature.languageSwitcher, false),
          ],
        );

        repository.updateFeatureFlag(
          const FeatureFlag(Feature.contactUsHomeFab, false),
        );

        expect(
          repository.getFeatureFlags(),
          const [
            FeatureFlag(Feature.contactUsHomeFab, false),
            FeatureFlag(Feature.languageSwitcher, false),
          ],
        );

        repository.reset();

        expect(
          repository.getFeatureFlags(),
          const [
            FeatureFlag(Feature.contactUsHomeFab, true),
            FeatureFlag(Feature.languageSwitcher, false),
          ],
        );
      });
    });

    group('updateFeatureFlag', () {
      test('should update the Feature', () {
        final configs = {
          'contact_us_home_fab': RemoteConfigValue(
            utf8.encode('true'),
            ValueSource.valueStatic,
          ),
          'language_switcher': RemoteConfigValue(
            utf8.encode('false'),
            ValueSource.valueRemote,
          ),
        };
        mockFbRemoteConfigController.mockGetAllConfigsValue(configs);

        repository.initFeatureFlags();

        expect(
          repository.getFeatureFlags(),
          const [
            FeatureFlag(Feature.contactUsHomeFab, true),
            FeatureFlag(Feature.languageSwitcher, false),
          ],
        );

        repository.updateFeatureFlag(
          const FeatureFlag(Feature.contactUsHomeFab, false),
        );

        expect(
          repository.getFeatureFlags(),
          const [
            FeatureFlag(Feature.contactUsHomeFab, false),
            FeatureFlag(Feature.languageSwitcher, false),
          ],
        );
      });
    });
  });
}
