// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'career_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CareerModel _$CareerModelFromJson(Map<String, dynamic> json) => CareerModel(
  name: json['name'] as String,
  email: json['email'] as String,
  role: json['role'] as String,
  country: json['country'] as String,
  message: json['message'] as String,
  resumeName: json['resumeName'] as String,
  resumeUrl: json['resumeUrl'] as String,
  uploadedAt: json['uploadedAt'] as String,
  env: json['env'] as String,
);

Map<String, dynamic> _$CareerModelToJson(CareerModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'role': instance.role,
      'country': instance.country,
      'message': instance.message,
      'resumeName': instance.resumeName,
      'resumeUrl': instance.resumeUrl,
      'uploadedAt': instance.uploadedAt,
      'env': instance.env,
    };
