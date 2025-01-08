import 'package:mocktail/mocktail.dart';
import 'package:use_case/use_case.dart';
import 'package:wahl_analytics/src/feature/contact/domain/domain.dart';

class MockSubmitContactUsApplicationUseCase extends Mock
    implements SubmitContactUsApplicationUseCase {
  void mockCallSuccess(BusinessContactEntity expected) {
    when(() => call(any())).thenAnswer((_) async => const Right(null));
  }

  void mockCallFailure(SubmitContactUsApplicationFailure failure) {
    when(() => call(any())).thenAnswer((_) async => Left(failure));
  }
}
