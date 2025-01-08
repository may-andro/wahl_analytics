import 'package:mocktail/mocktail.dart';
import 'package:wahl_analytics/src/feature/service/domain/domain.dart';

class MockServiceRepository extends Mock implements ServiceRepository {
  void mockGetBusinessService(BusinessServiceEntity expected) {
    when(getBusinessService).thenAnswer((_) async => expected);
  }

  void mockGetBusinessServiceThrowsException(Object exception) {
    when(getBusinessService).thenThrow(exception);
  }
}
