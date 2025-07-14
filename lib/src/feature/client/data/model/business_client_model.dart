import 'package:json_annotation/json_annotation.dart';
import 'package:wahl_analytics/src/feature/client/data/model/client_model.dart';

part 'business_client_model.g.dart';

@JsonSerializable()
class BusinessClientModel {
  const BusinessClientModel({
    required this.name,
    required this.title,
    required this.description,
    required this.action,
    required this.clients,
  });

  factory BusinessClientModel.fromJson(Map<String, dynamic> json) {
    final clients = (json['clients'] as List<dynamic>).map((client) {
      return ClientModel.fromJson(Map<String, dynamic>.from(client as Map));
    }).toList();
    return BusinessClientModel(
      name: json['name'] as String,
      title: json['title'] as String,
      description: json['shortDescription'] as String,
      action: json['action'] as String,
      clients: clients,
    );
  }

  //_$BusinessClientSectionModelFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessClientModelToJson(this);

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'shortDescription')
  final String description;

  @JsonKey(name: 'action')
  final String action;

  @JsonKey(name: 'clients')
  final List<ClientModel> clients;
}
