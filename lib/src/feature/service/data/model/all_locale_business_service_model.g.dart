// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_locale_business_service_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllLocaleBusinessServiceModel _$AllLocaleBusinessServiceModelFromJson(
  Map<String, dynamic> json,
) => AllLocaleBusinessServiceModel(
  en: BusinessServiceModel.fromJson(json['en'] as Map<String, dynamic>),
  es: BusinessServiceModel.fromJson(json['es'] as Map<String, dynamic>),
  nl: BusinessServiceModel.fromJson(json['nl'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AllLocaleBusinessServiceModelToJson(
  AllLocaleBusinessServiceModel instance,
) => <String, dynamic>{
  'en': instance.en.toJson(),
  'es': instance.es.toJson(),
  'nl': instance.nl.toJson(),
};
