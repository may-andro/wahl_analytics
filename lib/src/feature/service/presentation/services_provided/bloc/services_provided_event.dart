import 'package:equatable/equatable.dart';
import 'package:wahl_analytics/src/feature/service/domain/domain.dart';

sealed class ServicesProvidedEvent extends Equatable {
  const ServicesProvidedEvent();

  @override
  List<Object> get props => [];
}

final class SetBusinessServiceEntityEvent extends ServicesProvidedEvent {
  const SetBusinessServiceEntityEvent(this.services);

  final List<ServiceEntity> services;
}
