import 'package:json_annotation/json_annotation.dart';
import 'package:wahl_analytics/src/feature/team/data/model/team_member_model.dart';

part 'business_team_model.g.dart';

@JsonSerializable()
class BusinessTeamModel {
  const BusinessTeamModel({
    required this.name,
    required this.title,
    required this.description,
    required this.action,
    required this.members,
  });

  factory BusinessTeamModel.fromJson(Map<String, dynamic> json) {
    final members = (json['members'] as List<dynamic>).map(
      (member) {
        return TeamMemberModel.fromJson(
          Map<String, dynamic>.from(member as Map),
        );
      },
    ).toList();
    return BusinessTeamModel(
      name: json['name'] as String,
      title: json['title'] as String,
      description: json['shortDescription'] as String,
      action: json['action'] as String,
      members: members,
    );
  }

  Map<String, dynamic> toJson() => _$BusinessTeamModelToJson(this);

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'shortDescription')
  final String description;

  @JsonKey(name: 'action')
  final String action;

  @JsonKey(name: 'members')
  final List<TeamMemberModel> members;
}
