// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientModel _$ClientModelFromJson(Map<String, dynamic> json) => ClientModel(
  url: json['url'] as String,
  name: json['name'] as String,
  shortDescription: json['shortDescription'] as String,
  longDescription: json['longDescription'] as String,
  services:
      (json['servicesProvided'] as List<dynamic>)
          .map((e) => ServiceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$ClientModelToJson(ClientModel instance) =>
    <String, dynamic>{
      'url': instance.url,
      'name': instance.name,
      'shortDescription': instance.shortDescription,
      'longDescription': instance.longDescription,
      'servicesProvided': instance.services.map((e) => e.toJson()).toList(),
    };
