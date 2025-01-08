import 'package:equatable/equatable.dart';
import 'package:wahl_analytics/src/feature/team/domain/entity/team_member_entity.dart';

class BusinessTeamEntity extends Equatable {
  const BusinessTeamEntity({
    required this.name,
    required this.title,
    required this.description,
    required this.action,
    required this.members,
  });

  final String name;
  final String title;
  final String description;
  final String action;
  final List<TeamMemberEntity> members;

  @override
  List<Object?> get props => [
        name,
        title,
        description,
        action,
        members,
      ];
}
