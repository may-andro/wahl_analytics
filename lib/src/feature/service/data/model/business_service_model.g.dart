// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_service_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusinessServiceModel _$BusinessServiceModelFromJson(
  Map<String, dynamic> json,
) => BusinessServiceModel(
  name: json['name'] as String,
  title: json['title'] as String,
  shortDescription: json['shortDescription'] as String,
  action: json['action'] as String,
  services: (json['services'] as List<dynamic>)
      .map((e) => ServiceModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$BusinessServiceModelToJson(
  BusinessServiceModel instance,
) => <String, dynamic>{
  'name': instance.name,
  'title': instance.title,
  'shortDescription': instance.shortDescription,
  'action': instance.action,
  'services': instance.services.map((e) => e.toJson()).toList(),
};
