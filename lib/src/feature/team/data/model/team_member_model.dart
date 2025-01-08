import 'package:json_annotation/json_annotation.dart';
import 'package:wahl_analytics/src/feature/service/service.dart';

part 'team_member_model.g.dart';

@JsonSerializable()
class TeamMemberModel {
  const TeamMemberModel({
    required this.url,
    required this.name,
    required this.role,
    required this.shortDescription,
    required this.longDescription,
    required this.services,
  });

  factory TeamMemberModel.fromJson(Map<String, dynamic> json) {
    final services = (json['services'] as List<dynamic>).map(
      (service) {
        return ServiceModel.fromJson(
          Map<String, dynamic>.from(service as Map),
        );
      },
    ).toList();

    return TeamMemberModel(
      url: json['url'] as String,
      name: json['name'] as String,
      role: json['role'] as String,
      shortDescription: json['shortDescription'] as String,
      longDescription: json['longDescription'] as String,
      services: services,
    );
  }

  Map<String, dynamic> toJson() => _$TeamMemberModelToJson(this);

  @JsonKey(name: 'url')
  final String url;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'role')
  final String role;

  @JsonKey(name: 'shortDescription')
  final String shortDescription;

  @JsonKey(name: 'longDescription')
  final String longDescription;

  @JsonKey(name: 'services')
  final List<ServiceModel> services;
}
