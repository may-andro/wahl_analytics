import 'package:mocktail/mocktail.dart';
import 'package:use_case/use_case.dart';
import 'package:wahl_analytics/src/feature/validation/domain/domain.dart';

class MockIsValidCountryUseCase extends Mock implements IsValidCountryUseCase {
  void mockCallSuccess(bool expected) {
    when(() => call(any())).thenAnswer((_) async => Right(expected));
  }

  void mockCallFailure(IsValidCountryFailure failure) {
    when(() => call(any())).thenAnswer((_) async => Left(failure));
  }
}
