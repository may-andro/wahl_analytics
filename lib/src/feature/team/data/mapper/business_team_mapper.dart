import 'package:core/core.dart';
import 'package:wahl_analytics/src/feature/team/data/mapper/team_member_mapper.dart';
import 'package:wahl_analytics/src/feature/team/data/model/model.dart';
import 'package:wahl_analytics/src/feature/team/domain/domain.dart';

class BusinessTeamMapper
    implements Mapper<BusinessTeamModel, BusinessTeamEntity> {
  BusinessTeamMapper(this._teamMemberMapper);

  final TeamMemberMapper _teamMemberMapper;

  @override
  BusinessTeamEntity map(BusinessTeamModel from) {
    return BusinessTeamEntity(
      name: from.name,
      title: from.title,
      description: from.description,
      action: from.action,
      members: from.members.map(_teamMemberMapper.map).toList(),
    );
  }
}
