import 'package:design_system/design_system.dart';
import 'package:equatable/equatable.dart';
import 'package:wahl_analytics/src/feature/service/domain/domain.dart';

class ServicesProvidedState extends Equatable {
  const ServicesProvidedState({
    this.viewState = DSViewState.loading,
    this.services,
  });

  final DSViewState viewState;
  final List<ServiceEntity>? services;

  @override
  List<Object?> get props => [viewState, services];

  ServicesProvidedState copyWith({
    DSViewState? viewState,
    List<ServiceEntity>? services,
  }) {
    return ServicesProvidedState(
      viewState: viewState ?? this.viewState,
      services: services ?? this.services,
    );
  }
}
