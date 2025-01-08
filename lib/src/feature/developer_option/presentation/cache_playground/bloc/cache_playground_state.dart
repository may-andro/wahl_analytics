import 'package:design_system/design_system.dart';
import 'package:equatable/equatable.dart';
import 'package:wahl_analytics/src/feature/developer_option/domain/entity/dummy_entity.dart';

class CachePlaygroundState extends Equatable {
  const CachePlaygroundState({
    this.viewState = DSViewState.loading,
    this.dummyLists,
  });

  final DSViewState viewState;
  final List<DummyEntity>? dummyLists;

  @override
  List<Object?> get props => [
        viewState,
        dummyLists,
      ];

  CachePlaygroundState copyWith({
    DSViewState? viewState,
    List<DummyEntity>? dummyLists,
  }) {
    return CachePlaygroundState(
      viewState: viewState ?? this.viewState,
      dummyLists: dummyLists ?? this.dummyLists,
    );
  }
}
