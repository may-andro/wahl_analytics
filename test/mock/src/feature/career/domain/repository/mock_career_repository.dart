import 'package:mocktail/mocktail.dart';
import 'package:wahl_analytics/src/feature/career/domain/domain.dart';

class MockCareerRepository extends Mock implements CareerRepository {
  void mockSubmitCareerApplication() {
    when(() => submitCareerApplication(any())).thenAnswer((_) async => {});
  }

  void mockSubmitCareerApplicationThrowsException(Object exception) {
    when(() => submitCareerApplication(any())).thenThrow(exception);
  }

  void mockGetCareersRequest(List<CareerEntity> expected) {
    when(getCareersRequest).thenAnswer((_) async => expected);
  }

  void mockGetCareersRequestThrowsException(Object exception) {
    when(getCareersRequest).thenThrow(exception);
  }

  void mockDeleteCareerRequest() {
    when(() => deleteCareerRequest(any())).thenAnswer((_) async => {});
  }

  void mockDeleteCareerRequestThrowsException(Object exception) {
    when(() => deleteCareerRequest(any())).thenThrow(exception);
  }
}
