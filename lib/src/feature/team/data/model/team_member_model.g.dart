// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_member_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamMemberModel _$TeamMemberModelFromJson(Map<String, dynamic> json) =>
    TeamMemberModel(
      url: json['url'] as String,
      name: json['name'] as String,
      role: json['role'] as String,
      shortDescription: json['shortDescription'] as String,
      longDescription: json['longDescription'] as String,
      services:
          (json['services'] as List<dynamic>)
              .map((e) => ServiceModel.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$TeamMemberModelToJson(TeamMemberModel instance) =>
    <String, dynamic>{
      'url': instance.url,
      'name': instance.name,
      'role': instance.role,
      'shortDescription': instance.shortDescription,
      'longDescription': instance.longDescription,
      'services': instance.services.map((e) => e.toJson()).toList(),
    };
