// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_contact_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusinessContactModel _$BusinessContactModelFromJson(
  Map<String, dynamic> json,
) => BusinessContactModel(
  email: json['email'] as String,
  mobileNumber: json['mobileNumber'] as String,
  address: (json['address'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$BusinessContactModelToJson(
  BusinessContactModel instance,
) => <String, dynamic>{
  'email': instance.email,
  'mobileNumber': instance.mobileNumber,
  'address': instance.address,
};
