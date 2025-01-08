import 'package:equatable/equatable.dart';
import 'package:wahl_analytics/src/feature/developer_option/domain/entity/dummy_entity.dart';

sealed class CachePlaygroundEvent extends Equatable {
  const CachePlaygroundEvent();

  @override
  List<Object> get props => [];
}

final class OnInitEvent extends CachePlaygroundEvent {}

final class AddCacheDataEvent extends CachePlaygroundEvent {
  const AddCacheDataEvent({
    required this.dummyEntity,
  });

  final DummyEntity dummyEntity;
}

final class DeleteCacheDataEvent extends CachePlaygroundEvent {
  const DeleteCacheDataEvent({
    required this.dummyEntity,
  });

  final DummyEntity dummyEntity;
}
