import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wahl_analytics/src/feature/developer_option/presentation/dev_mode/bloc/dev_mode_event.dart';
import 'package:wahl_analytics/src/feature/developer_option/presentation/dev_mode/bloc/dev_mode_state.dart';
import 'package:wahl_analytics/src/feature/developer_option/presentation/dev_mode/tracking/dev_mode_tracking_delegate.dart';

class DevModeBloc extends Bloc<DevModeEvent, DevModeState> {
  DevModeBloc(this._trackingDelegate) : super(const DevModeState()) {
    on<OpenDBCacheScreenEvent>(_mapOpenDBCacheScreenEvent);
    on<ScreenVisibleEvent>(_mapScreenVisibleEventToState);
  }

  final DevModeTrackingDelegate _trackingDelegate;

  FutureOr<void> _mapOpenDBCacheScreenEvent(
    OpenDBCacheScreenEvent event,
    Emitter<DevModeState> emit,
  ) {}

  FutureOr<void> _mapScreenVisibleEventToState(
    ScreenVisibleEvent event,
    Emitter<DevModeState> emit,
  ) {
    _trackingDelegate.trackScreenView();
  }
}

extension DevModeBlocExtension on BuildContext {
  DevModeBloc get bloc => read<DevModeBloc>();
}
