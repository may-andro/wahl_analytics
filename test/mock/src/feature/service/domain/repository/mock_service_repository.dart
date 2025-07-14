import 'package:mocktail/mocktail.dart';
import 'package:wahl_analytics/src/feature/service/domain/domain.dart';

class MockServiceRepository extends Mock implements ServiceRepository {
  void mockGetBusinessService(AllLocaleBusinessServiceEntity expected) {
    when(getBusinessService).thenAnswer((_) async => expected);
  }

  void mockGetBusinessServiceThrowsException(Object exception) {
    when(getBusinessService).thenThrow(exception);
  }

  void mockGetBusinessServiceForLocale(BusinessServiceEntity expected) {
    when(getBusinessServiceForLocale).thenAnswer((_) async => expected);
  }

  void mockGetBusinessServiceForLocaleThrowsException(Object exception) {
    when(getBusinessServiceForLocale).thenThrow(exception);
  }

  void mockUpdateAllLocaleBusinessService() {
    when(
      () => updateAllLocaleBusinessService(any()),
    ).thenAnswer((_) async => {});
  }

  void mockUpdateAllLocaleBusinessServiceThrowsException(Object exception) {
    when(() => updateAllLocaleBusinessService(any())).thenThrow(exception);
  }
}
