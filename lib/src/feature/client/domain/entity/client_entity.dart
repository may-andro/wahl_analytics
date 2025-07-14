import 'package:equatable/equatable.dart';
import 'package:wahl_analytics/src/feature/service/service.dart';

class ClientEntity extends Equatable {
  const ClientEntity({
    required this.url,
    required this.name,
    required this.shortDescription,
    required this.longDescription,
    required this.services,
  });

  final String url;
  final String name;
  final String shortDescription;
  final String longDescription;
  final List<ServiceEntity> services;

  @override
  List<Object?> get props {
    return [url, name, shortDescription, longDescription, services];
  }
}
