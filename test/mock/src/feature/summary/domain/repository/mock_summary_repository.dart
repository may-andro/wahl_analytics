import 'package:mocktail/mocktail.dart';
import 'package:wahl_analytics/src/feature/summary/domain/domain.dart';

class MockSummaryRepository extends Mock implements SummaryRepository {
  void mockGetBusinessSummary(BusinessSummaryEntity expected) {
    when(getBusinessSummary).thenAnswer((_) async => expected);
  }

  void mockGetBusinessSummaryThrowsException(Object exception) {
    when(getBusinessSummary).thenThrow(exception);
  }
}
