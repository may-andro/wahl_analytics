// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_verification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthVerificationModel _$AuthVerificationModelFromJson(
  Map<String, dynamic> json,
) => AuthVerificationModel(
  code: json['code'] as String,
  createdAt: const TimestampConverter().fromJson(
    json['createdAt'] as Timestamp,
  ),
);

Map<String, dynamic> _$AuthVerificationModelToJson(
  AuthVerificationModel instance,
) => <String, dynamic>{
  'code': instance.code,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
};
