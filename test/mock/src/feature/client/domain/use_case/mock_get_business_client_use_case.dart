import 'package:mocktail/mocktail.dart';
import 'package:use_case/use_case.dart';
import 'package:wahl_analytics/src/feature/client/domain/domain.dart';

class MockGetBusinessClientUseCase extends Mock
    implements GetBusinessClientUseCase {
  void mockCallSuccess(BusinessClientEntity expected) {
    when(call).thenAnswer((_) => Right(expected));
  }

  void mockCallFailure(BusinessClientFailure failure) {
    when(call).thenAnswer((_) => Left(failure));
  }
}
