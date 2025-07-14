import 'dart:async';

import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wahl_analytics/src/feature/developer_option/presentation/tracking_log/bloc/tracking_log_event.dart';
import 'package:wahl_analytics/src/feature/developer_option/presentation/tracking_log/bloc/tracking_log_state.dart';
import 'package:wahl_analytics/src/feature/developer_option/presentation/tracking_log/tracking/tracking_log_tracking_delegate.dart';

class TrackingLogBloc extends Bloc<TrackingLogEvent, TrackingLogState> {
  TrackingLogBloc(this._trackingDelegate) : super(const TrackingLogState()) {
    on<OnInitEvent>(_mapOnInitEventToState);
    on<ScreenVisibleEvent>(_mapScreenVisibleEventToState);
  }

  final TrackingLogTrackingDelegate _trackingDelegate;

  FutureOr<void> _mapOnInitEventToState(
    OnInitEvent event,
    Emitter<TrackingLogState> emit,
  ) {
    emit(
      TrackingLogState(
        trackingLogs: _trackingDelegate.sentTrackingEvents,
        viewState: DSViewState.idle,
      ),
    );
  }

  FutureOr<void> _mapScreenVisibleEventToState(
    ScreenVisibleEvent event,
    Emitter<TrackingLogState> emit,
  ) {
    _trackingDelegate.trackScreenView();
  }
}

extension ContextExtension on BuildContext {
  TrackingLogBloc get bloc => read<TrackingLogBloc>();

  TrackingLogState get state => bloc.state;
}
