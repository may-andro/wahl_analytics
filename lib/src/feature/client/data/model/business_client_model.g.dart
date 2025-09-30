// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_client_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusinessClientModel _$BusinessClientModelFromJson(Map<String, dynamic> json) =>
    BusinessClientModel(
      name: json['name'] as String,
      title: json['title'] as String,
      description: json['shortDescription'] as String,
      action: json['action'] as String,
      clients: (json['clients'] as List<dynamic>)
          .map((e) => ClientModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BusinessClientModelToJson(
  BusinessClientModel instance,
) => <String, dynamic>{
  'name': instance.name,
  'title': instance.title,
  'shortDescription': instance.description,
  'action': instance.action,
  'clients': instance.clients.map((e) => e.toJson()).toList(),
};
