import 'package:mocktail/mocktail.dart';
import 'package:use_case/use_case.dart';
import 'package:wahl_analytics/src/feature/validation/domain/domain.dart';

class MockIsValidRoleUseCase extends Mock implements IsValidRoleUseCase {
  void mockCallSuccess(bool expected) {
    when(() => call(any())).thenAnswer((_) => Right(expected));
  }

  void mockCallFailure(IsValidRoleFailure failure) {
    when(() => call(any())).thenAnswer((_) => Left(failure));
  }
}
