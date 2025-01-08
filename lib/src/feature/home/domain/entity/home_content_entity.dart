import 'package:equatable/equatable.dart';
import 'package:wahl_analytics/src/feature/client/client.dart';
import 'package:wahl_analytics/src/feature/service/service.dart';
import 'package:wahl_analytics/src/feature/team/team.dart';

sealed class HomeContentEntity extends Equatable {
  const HomeContentEntity();
}

class HeaderSection extends HomeContentEntity {
  const HeaderSection({
    required this.title,
    required this.descriptions,
    required this.urls,
  });

  final String title;

  final List<String> descriptions;

  final List<String> urls;

  @override
  List<Object?> get props {
    return [
      descriptions,
      urls,
    ];
  }
}

class FooterSection extends HomeContentEntity {
  const FooterSection({
    required this.email,
    required this.mobileNumber,
    required this.address,
  });

  final String email;

  final String mobileNumber;

  final List<String> address;

  @override
  List<Object?> get props {
    return [
      email,
      mobileNumber,
      address,
    ];
  }
}

sealed class BodySection extends HomeContentEntity {
  const BodySection({
    required this.name,
    required this.title,
    required this.description,
    required this.action,
  });

  final String name;

  final String title;

  final String description;

  final String action;
}

class ClientSection extends BodySection {
  const ClientSection({
    required super.name,
    required super.title,
    required super.description,
    required super.action,
    required this.clients,
  });

  final List<ClientEntity> clients;

  @override
  List<Object?> get props {
    return [
      name,
      title,
      description,
      action,
      clients,
    ];
  }
}

class ServiceSection extends BodySection {
  const ServiceSection({
    required super.name,
    required super.title,
    required super.description,
    required super.action,
    required this.services,
  });

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
}

class TeamSection extends BodySection {
  const TeamSection({
    required super.name,
    required super.title,
    required super.description,
    required super.action,
    required this.members,
  });

  final List<TeamMemberEntity> members;

  @override
  List<Object?> get props {
    return [
      name,
      title,
      description,
      action,
      members,
    ];
  }
}
