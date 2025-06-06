import 'package:mocktail/mocktail.dart';
import 'package:use_case/use_case.dart';
import 'package:wahl_analytics/src/feature/validation/domain/domain.dart';

class MockIsValidEmailUseCase extends Mock implements IsValidEmailUseCase {
  void mockCallSuccess(bool expected) {
    when(() => call(any())).thenAnswer((_) => Right(expected));
  }

  void mockCallFailure(IsValidEmailFailure failure) {
    when(() => call(any())).thenAnswer((_) => Left(failure));
  }
}
