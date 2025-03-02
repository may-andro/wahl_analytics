import 'package:json_annotation/json_annotation.dart';
import 'package:wahl_analytics/src/feature/service/data/model/business_service_model.dart';

part 'all_locale_business_service_model.g.dart';

@JsonSerializable()
class AllLocaleBusinessServiceModel {
  const AllLocaleBusinessServiceModel({
    required this.en,
    required this.es,
    required this.nl,
  });

  factory AllLocaleBusinessServiceModel.fromJson(Map<String, dynamic> json) =>
      _$AllLocaleBusinessServiceModelFromJson(json);

  Map<String, dynamic> toJson() => _$AllLocaleBusinessServiceModelToJson(this);

  @JsonKey(name: 'en')
  final BusinessServiceModel en;

  @JsonKey(name: 'es')
  final BusinessServiceModel es;

  @JsonKey(name: 'nl')
  final BusinessServiceModel nl;
}
