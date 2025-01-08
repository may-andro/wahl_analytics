import 'package:mocktail/mocktail.dart';
import 'package:use_case/use_case.dart';
import 'package:wahl_analytics/src/feature/validation/domain/domain.dart';

class MockIsValidNameUseCase extends Mock implements IsValidNameUseCase {
  void mockCallSuccess(bool expected) {
    when(() => call(any())).thenAnswer((_) async => Right(expected));
  }

  void mockCallFailure(IsValidNameFailure failure) {
    when(() => call(any())).thenAnswer((_) async => Left(failure));
  }
}
