import 'package:core/core.dart';
import 'package:wahl_analytics/src/feature/service/service.dart';
import 'package:wahl_analytics/src/feature/team/data/model/model.dart';
import 'package:wahl_analytics/src/feature/team/domain/domain.dart';

class TeamMemberMapper implements Mapper<TeamMemberModel, TeamMemberEntity> {
  TeamMemberMapper(this._serviceMapper);

  final ServiceMapper _serviceMapper;

  @override
  TeamMemberEntity map(TeamMemberModel from) {
    return TeamMemberEntity(
      url: from.url,
      name: from.name,
      role: from.role,
      shortDescription: from.shortDescription,
      longDescription: from.longDescription,
      services: from.services.map(_serviceMapper.to).toList(),
    );
  }
}
