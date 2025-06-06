import 'package:mocktail/mocktail.dart';
import 'package:use_case/use_case.dart';
import 'package:wahl_analytics/src/feature/career/domain/domain.dart';

class MockSubmitCareerApplicationUseCase extends Mock
    implements SubmitCareerApplicationUseCase {
  void mockCallSuccess() {
    when(() => call(any())).thenAnswer((_) => const Right(null));
  }

  void mockCallFailure(SubmitCareerApplicationFailure failure) {
    when(() => call(any())).thenAnswer((_) => Left(failure));
  }
}
