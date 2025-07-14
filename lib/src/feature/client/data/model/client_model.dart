import 'package:json_annotation/json_annotation.dart';
import 'package:wahl_analytics/src/feature/service/service.dart';

part 'client_model.g.dart';

@JsonSerializable()
class ClientModel {
  const ClientModel({
    required this.url,
    required this.name,
    required this.shortDescription,
    required this.longDescription,
    required this.services,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    final services = (json['servicesProvided'] as List<dynamic>).map((service) {
      return ServiceModel.fromJson(Map<String, dynamic>.from(service as Map));
    }).toList();
    return ClientModel(
      url: json['url'] as String,
      name: json['name'] as String,
      shortDescription: json['shortDescription'] as String,
      longDescription: json['longDescription'] as String,
      services: services,
    );
  }

  Map<String, dynamic> toJson() => _$ClientModelToJson(this);

  @JsonKey(name: 'url')
  final String url;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'shortDescription')
  final String shortDescription;

  @JsonKey(name: 'longDescription')
  final String longDescription;

  @JsonKey(name: 'servicesProvided')
  final List<ServiceModel> services;
}
