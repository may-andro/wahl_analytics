import 'package:mocktail/mocktail.dart';
import 'package:wahl_analytics/src/feature/contact/domain/domain.dart';

class MockContactRepository extends Mock implements ContactRepository {
  void mockGetBusinessContact(BusinessContactEntity expected) {
    when(getBusinessContact).thenAnswer((_) async => expected);
  }

  void mockGetBusinessContactThrowsException(Object exception) {
    when(getBusinessContact).thenThrow(exception);
  }

  void mockSubmitApplication() {
    when(() => submitApplication(any())).thenAnswer((_) async => {});
  }

  void mockSubmitApplicationThrowsException(Object exception) {
    when(() => submitApplication(any())).thenThrow(exception);
  }
}
