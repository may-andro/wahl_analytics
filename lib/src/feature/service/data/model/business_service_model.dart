import 'package:json_annotation/json_annotation.dart';
import 'package:wahl_analytics/src/feature/service/data/model/service_model.dart';

part 'business_service_model.g.dart';

@JsonSerializable()
class BusinessServiceModel {
  const BusinessServiceModel({
    required this.name,
    required this.title,
    required this.shortDescription,
    required this.action,
    required this.services,
  });

  factory BusinessServiceModel.fromJson(Map<String, dynamic> json) =>
      _$BusinessServiceModelFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessServiceModelToJson(this);

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'shortDescription')
  final String shortDescription;

  @JsonKey(name: 'action')
  final String action;

  @JsonKey(name: 'services')
  final List<ServiceModel> services;
}
