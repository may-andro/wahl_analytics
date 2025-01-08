import 'package:feature_flag/src/data/data.dart';
import 'package:feature_flag/src/data/model/feature_model.dart';
import 'package:mocktail/mocktail.dart';

class MockFeatureFlagCache extends Mock implements FeatureFlagCache {
  void mockGetAll(List<FeatureModel> expected) {
    when(getAll).thenAnswer((_) async => expected);
  }

  void mockGetAllThrowsException() {
    when(getAll).thenThrow(Exception('Cache error'));
  }

  void mockGet(FeatureModel? expected) {
    when(
      () => get(
        where: any(named: 'where'),
        arguments: any(named: 'arguments'),
      ),
    ).thenAnswer((_) async => expected);
  }

  void mockPut() {
    when(() => put(any())).thenAnswer((_) async => {});
  }

  void mockPutThrowsException() {
    when(() => put(any())).thenThrow(Exception('Cache error'));
  }

  void mockDeleteAll() {
    when(deleteAll).thenAnswer((_) async => {});
  }
}
