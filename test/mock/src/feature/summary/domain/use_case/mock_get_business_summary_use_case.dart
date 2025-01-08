import 'package:mocktail/mocktail.dart';
import 'package:use_case/use_case.dart';
import 'package:wahl_analytics/src/feature/summary/domain/domain.dart';

class MockGetBusinessSummaryUseCase extends Mock
    implements GetBusinessSummaryUseCase {
  void mockCallSuccess(BusinessSummaryEntity expected) {
    when(call).thenAnswer((_) async => Right(expected));
  }

  void mockCallFailure(BusinessSummaryFailure failure) {
    when(call).thenAnswer((_) async => Left(failure));
  }
}
