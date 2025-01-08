import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wahl_analytics/src/feature/developer_option/presentation/dev_mode/bloc/dev_mode_event.dart';
import 'package:wahl_analytics/src/feature/developer_option/presentation/dev_mode/bloc/dev_mode_state.dart';

class DevModeBloc extends Bloc<DevModeEvent, DevModeState> {
  DevModeBloc() : super(const DevModeState()) {
    on<OpenDBCacheScreenEvent>(_mapOpenDBCacheScreenEvent);
  }

  FutureOr<void> _mapOpenDBCacheScreenEvent(
    OpenDBCacheScreenEvent event,
    Emitter<DevModeState> emit,
  ) {}
}
