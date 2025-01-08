import 'package:wahl_analytics/src/feature/team/domain/entity/entity.dart';

abstract class TeamRepository {
  Future<BusinessTeamEntity> getBusinessTeam();
}
