import 'package:json_annotation/json_annotation.dart';

part 'business_summary_model.g.dart';

@JsonSerializable()
class BusinessSummaryModel {
  const BusinessSummaryModel({
    required this.title,
    required this.descriptions,
    required this.urls,
  });

  factory BusinessSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$BusinessSummaryModelFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessSummaryModelToJson(this);

  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'descriptions')
  final List<String> descriptions;

  @JsonKey(name: 'urls')
  final List<String> urls;
}
