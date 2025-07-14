import 'package:json_annotation/json_annotation.dart';

part 'dummy_entity.g.dart';

@JsonSerializable()
class DummyEntity {
  DummyEntity({required this.name});

  factory DummyEntity.fromJson(Map<String, dynamic> json) =>
      _$DummyEntityFromJson(json);

  @JsonKey(name: 'name')
  final String name;

  Map<String, dynamic> toJson() => _$DummyEntityToJson(this);
}
