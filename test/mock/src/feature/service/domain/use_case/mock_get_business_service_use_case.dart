import 'package:mocktail/mocktail.dart';
import 'package:use_case/use_case.dart';
import 'package:wahl_analytics/src/feature/service/domain/domain.dart';

class MockGetBusinessServiceUseCase extends Mock
    implements GetBusinessServiceUseCase {
  void mockCallSuccess(BusinessServiceEntity expected) {
    when(call).thenAnswer((_) => Right(expected));
  }

  void mockCallFailure(BusinessServiceFailure failure) {
    when(call).thenAnswer((_) => Left(failure));
  }
}
