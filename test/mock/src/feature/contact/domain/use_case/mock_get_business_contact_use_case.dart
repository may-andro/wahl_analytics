import 'package:mocktail/mocktail.dart';
import 'package:use_case/use_case.dart';
import 'package:wahl_analytics/src/feature/contact/domain/domain.dart';

class MockGetBusinessContactUseCase extends Mock
    implements GetBusinessContactUseCase {
  void mockCallSuccess(BusinessContactEntity expected) {
    when(call).thenAnswer((_) async => Right(expected));
  }

  void mockCallFailure(BusinessContactFailure failure) {
    when(call).thenAnswer((_) async => Left(failure));
  }
}
