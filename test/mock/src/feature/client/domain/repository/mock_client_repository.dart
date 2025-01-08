import 'package:mocktail/mocktail.dart';
import 'package:wahl_analytics/src/feature/client/domain/domain.dart';

class MockClientRepository extends Mock implements ClientRepository {
  void mockGetBusinessClient(BusinessClientEntity expected) {
    when(getBusinessClient).thenAnswer((_) async => expected);
  }

  void mockGetBusinessClientThrowsException(Object exception) {
    when(getBusinessClient).thenThrow(exception);
  }
}
