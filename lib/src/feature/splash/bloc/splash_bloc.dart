import 'dart:async';

import 'package:dependency_injection/dependency_injection.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wahl_analytics/src/feature/splash/bloc/splash_event.dart';
import 'package:wahl_analytics/src/feature/splash/bloc/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc(
    this._diController,
    this._moduleConfigurators,
  ) : super(SetUpProgress.initial()) {
    on<StartSetUp>(_onStartEvent);
  }

  final DIController _diController;

  final List<ModuleConfigurator> _moduleConfigurators;

  final _receivedSetUpStatus = <DISetUpStatus>[];

  bool errorDuringDI = false;

  FutureOr<void> _onStartEvent(
    StartSetUp event,
    Emitter<SplashState> emit,
  ) async {
    await emit.onEach<DISetUpStatus>(
      _diController.setUpDIGraph(configurators: _moduleConfigurators),
      onData: (setUpStatus) {
        _receivedSetUpStatus.add(setUpStatus);
        final progress =
            _receivedSetUpStatus.length / DISetUpStatus.values.length;
        emit(SetUpProgress(_receivedSetUpStatus, progress));
      },
      onError: (error, stackTrace) {
        if (error is DISetupException) {
          emit(SetUpError(error.message ?? error.cause ?? error));
        }
        emit(SetUpError(error));
        errorDuringDI = true;
      },
    );

    if (!errorDuringDI) {
      emit(const SetUpCompeted(DesignSystem.primary));
    }
  }
}
