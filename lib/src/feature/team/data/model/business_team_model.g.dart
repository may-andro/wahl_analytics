// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_team_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusinessTeamModel _$BusinessTeamModelFromJson(Map<String, dynamic> json) =>
    BusinessTeamModel(
      name: json['name'] as String,
      title: json['title'] as String,
      description: json['shortDescription'] as String,
      action: json['action'] as String,
      members:
          (json['members'] as List<dynamic>)
              .map((e) => TeamMemberModel.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$BusinessTeamModelToJson(BusinessTeamModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'title': instance.title,
      'shortDescription': instance.description,
      'action': instance.action,
      'members': instance.members.map((e) => e.toJson()).toList(),
    };
