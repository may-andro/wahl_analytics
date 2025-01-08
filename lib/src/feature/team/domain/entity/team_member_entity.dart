import 'package:equatable/equatable.dart';
import 'package:wahl_analytics/src/feature/service/service.dart';

class TeamMemberEntity extends Equatable {
  const TeamMemberEntity({
    required this.url,
    required this.name,
    required this.role,
    required this.shortDescription,
    required this.longDescription,
    required this.services,
  });

  final String url;
  final String name;
  final String role;
  final String shortDescription;
  final String longDescription;
  final List<ServiceEntity> services;

  @override
  List<Object?> get props => [
        url,
        name,
        role,
        shortDescription,
        longDescription,
        services,
      ];
}
