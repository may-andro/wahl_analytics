import 'dart:async';

import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wahl_analytics/src/feature/developer_option/domain/domain.dart';
import 'package:wahl_analytics/src/feature/developer_option/presentation/cache_playground/bloc/cache_playground_event.dart';
import 'package:wahl_analytics/src/feature/developer_option/presentation/cache_playground/bloc/cache_playground_state.dart';
import 'package:wahl_analytics/src/feature/developer_option/presentation/cache_playground/tracking/cache_playground_tracking_delegate.dart';

class CachePlaygroundBloc
    extends Bloc<CachePlaygroundEvent, CachePlaygroundState> {
  CachePlaygroundBloc(this._dummyEntityCache, this._trackingDelegate)
    : super(const CachePlaygroundState()) {
    on<OnInitEvent>(_mapOnInitEvent);
    on<AddCacheDataEvent>(_mapAddCacheDataEvent);
    on<DeleteCacheDataEvent>(_mapDeleteCacheDataEvent);
    on<ScreenVisibleEvent>(_mapScreenVisibleEventToState);
  }

  final DummyEntityCache _dummyEntityCache;
  final CachePlaygroundTrackingDelegate _trackingDelegate;

  FutureOr<void> _mapOnInitEvent(
    OnInitEvent event,
    Emitter<CachePlaygroundState> emit,
  ) async {
    final dummyLists = await _dummyEntityCache.getAll();
    emit(
      CachePlaygroundState(dummyLists: dummyLists, viewState: DSViewState.idle),
    );
  }

  FutureOr<void> _mapAddCacheDataEvent(
    AddCacheDataEvent event,
    Emitter<CachePlaygroundState> emit,
  ) async {
    await _dummyEntityCache.put(event.dummyEntity);
    final dummyLists = await _dummyEntityCache.getAll();
    emit(CachePlaygroundState(dummyLists: dummyLists));
  }

  FutureOr<void> _mapDeleteCacheDataEvent(
    DeleteCacheDataEvent event,
    Emitter<CachePlaygroundState> emit,
  ) async {
    await _dummyEntityCache.delete('name = ?', [event.dummyEntity.name]);
    final dummyLists = await _dummyEntityCache.getAll();
    emit(CachePlaygroundState(dummyLists: dummyLists));
  }

  FutureOr<void> _mapScreenVisibleEventToState(
    ScreenVisibleEvent event,
    Emitter<CachePlaygroundState> emit,
  ) {
    _trackingDelegate.trackScreenView();
  }
}

extension ContextExtension on BuildContext {
  CachePlaygroundBloc get bloc => read<CachePlaygroundBloc>();

  CachePlaygroundState get state => bloc.state;
}
