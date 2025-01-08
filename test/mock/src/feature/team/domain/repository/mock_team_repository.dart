import 'package:mocktail/mocktail.dart';
import 'package:wahl_analytics/src/feature/team/domain/domain.dart';

class MockTeamRepository extends Mock implements TeamRepository {
  void mockGetBusinessTeam(BusinessTeamEntity expected) {
    when(getBusinessTeam).thenAnswer((_) async => expected);
  }

  void mockGetBusinessTeamThrowsException(Object exception) {
    when(getBusinessTeam).thenThrow(exception);
  }
}
