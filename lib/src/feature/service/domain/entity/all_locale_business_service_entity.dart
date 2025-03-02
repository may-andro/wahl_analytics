import 'package:equatable/equatable.dart';
import 'package:wahl_analytics/src/feature/service/domain/entity/business_service_entity.dart';

class AllLocaleBusinessServiceEntity extends Equatable {
  const AllLocaleBusinessServiceEntity({
    required this.en,
    required this.es,
    required this.nl,
  });

  final BusinessServiceEntity es;
  final BusinessServiceEntity en;
  final BusinessServiceEntity nl;

  @override
  List<Object?> get props {
    return [
      en,
      es,
      nl,
    ];
  }

  AllLocaleBusinessServiceEntity copyWith({
    BusinessServiceEntity? en,
    BusinessServiceEntity? es,
    BusinessServiceEntity? nl,
  }) {
    return AllLocaleBusinessServiceEntity(
      en: en ?? this.en,
      es: es ?? this.es,
      nl: nl ?? this.nl,
    );
  }
}
