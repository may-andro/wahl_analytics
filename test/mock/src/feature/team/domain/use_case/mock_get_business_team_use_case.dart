import 'package:mocktail/mocktail.dart';
import 'package:use_case/use_case.dart';
import 'package:wahl_analytics/src/feature/team/domain/domain.dart';

class MockGetBusinessTeamUseCase extends Mock
    implements GetBusinessTeamUseCase {
  void mockCallSuccess(BusinessTeamEntity expected) {
    when(call).thenAnswer((_) async => Right(expected));
  }

  void mockCallFailure(BusinessTeamFailure failure) {
    when(call).thenAnswer((_) async => Left(failure));
  }
}
