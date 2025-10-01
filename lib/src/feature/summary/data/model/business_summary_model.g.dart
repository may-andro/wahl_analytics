// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusinessSummaryModel _$BusinessSummaryModelFromJson(
  Map<String, dynamic> json,
) => BusinessSummaryModel(
  title: json['title'] as String,
  descriptions: (json['descriptions'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  urls: (json['urls'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$BusinessSummaryModelToJson(
  BusinessSummaryModel instance,
) => <String, dynamic>{
  'title': instance.title,
  'descriptions': instance.descriptions,
  'urls': instance.urls,
};
