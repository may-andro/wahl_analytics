import 'package:equatable/equatable.dart';
import 'package:wahl_analytics/src/feature/service/domain/entity/service_entity.dart';

class BusinessServiceEntity extends Equatable {
  const BusinessServiceEntity({
    required this.name,
    required this.title,
    required this.description,
    required this.action,
    required this.services,
  });

  final String name;
  final String title;
  final String description;
  final String action;
  final List<ServiceEntity> services;

  @override
  List<Object?> get props {
    return [
      name,
      title,
      description,
      action,
      services,
    ];
  }

  BusinessServiceEntity copyWith({
    String? name,
    String? title,
    String? description,
    String? action,
    List<ServiceEntity>? services,
  }) {
    return BusinessServiceEntity(
      name: name ?? this.name,
      title: title ?? this.title,
      description: description ?? this.description,
      action: action ?? this.action,
      services: services ?? this.services,
    );
  }
}
