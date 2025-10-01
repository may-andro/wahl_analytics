// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feature_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeatureModel _$FeatureModelFromJson(Map<String, dynamic> json) => FeatureModel(
  name: json['name'] as String,
  isEnabled: (json['is_enabled'] as num).toInt(),
);

Map<String, dynamic> _$FeatureModelToJson(FeatureModel instance) =>
    <String, dynamic>{'name': instance.name, 'is_enabled': instance.isEnabled};
