import 'package:equatable/equatable.dart';
import 'package:wahl_analytics/src/feature/client/domain/entity/client_entity.dart';

class BusinessClientEntity extends Equatable {
  const BusinessClientEntity({
    required this.name,
    required this.title,
    required this.description,
    required this.action,
    required this.clients,
  });

  final String name;
  final String title;
  final String description;
  final String action;
  final List<ClientEntity> clients;

  @override
  List<Object?> get props {
    return [name, title, description, action, clients];
  }
}
