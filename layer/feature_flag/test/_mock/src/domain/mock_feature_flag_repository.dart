import 'package:feature_flag/src/domain/domain.dart';
import 'package:feature_flag/src/domain/repository/feature_flag_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockFeatureFlagRepository extends Mock implements FeatureFlagRepository {
  void mockInitFeatureFlags() {
    when(initFeatureFlags).thenAnswer((_) {});
  }

  void mockInitFeatureFlagsException() {
    when(initFeatureFlags).thenThrow(Exception());
  }

  void mockGetFeatureFlags(List<FeatureFlag> expected) {
    when(getFeatureFlags).thenAnswer((_) => expected);
  }

  void mockGetFeatureFlagsException() {
    when(getFeatureFlags).thenThrow(Exception());
  }

  void mockIsFeatureEnabled(bool expected) {
    when(() => isFeatureEnabled(any())).thenAnswer((_) => expected);
  }

  void mockIsFeatureEnabledException() {
    when(() => isFeatureEnabled(any())).thenThrow(Exception());
  }

  void mockUpdateFeatureFlag() {
    when(() => updateFeatureFlag(any())).thenReturn(null);
  }

  void mockUpdateFeatureFlagException() {
    when(() => updateFeatureFlag(any())).thenThrow(Exception());
  }

  void mockReset() {
    when(this.reset).thenAnswer((_) {});
  }

  void mockResetException() {
    when(this.reset).thenThrow(Exception());
  }
}
