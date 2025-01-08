import 'package:mocktail/mocktail.dart';
import 'package:wahl_analytics/src/feature/career/domain/domain.dart';

class MockCareerRepository extends Mock implements CareerRepository {
  void mockSubmitCareerApplication() {
    when(() => submitCareerApplication(any())).thenAnswer((_) async => {});
  }

  void mockSubmitCareerApplicationThrowsException(Object exception) {
    when(() => submitCareerApplication(any())).thenThrow(exception);
  }
}
