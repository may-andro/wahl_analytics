import 'package:json_annotation/json_annotation.dart';

part 'service_model.g.dart';

@JsonSerializable()
class ServiceModel {
  const ServiceModel({
    required this.icon,
    required this.title,
    required this.shortDescription,
    required this.longDescription,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceModelFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceModelToJson(this);

  @JsonKey(name: 'icon')
  final String icon;

  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'shortDescription')
  final String shortDescription;

  @JsonKey(name: 'longDescription')
  final String longDescription;
}
