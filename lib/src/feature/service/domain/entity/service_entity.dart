import 'package:equatable/equatable.dart';

class ServiceEntity extends Equatable {
  const ServiceEntity({
    required this.icon,
    required this.title,
    required this.shortDescription,
    required this.longDescription,
  });

  final String icon;
  final String title;
  final String shortDescription;
  final String longDescription;

  @override
  List<Object?> get props {
    return [
      icon,
      title,
      shortDescription,
      longDescription,
    ];
  }
}
