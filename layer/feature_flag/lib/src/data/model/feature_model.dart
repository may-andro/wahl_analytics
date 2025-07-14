import 'package:json_annotation/json_annotation.dart';

part 'feature_model.g.dart';

@JsonSerializable()
class FeatureModel {
  FeatureModel({required this.name, required this.isEnabled});

  factory FeatureModel.fromJson(Map<String, dynamic> json) =>
      _$FeatureModelFromJson(json);

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'is_enabled')
  final int isEnabled;

  Map<String, dynamic> toJson() => _$FeatureModelToJson(this);
}
