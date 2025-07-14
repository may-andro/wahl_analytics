import 'dart:async';

import 'package:dependency_injection/dependency_injection.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wahl_analytics/src/feature/splash/presentation/bloc/splash_event.dart';
import 'package:wahl_analytics/src/feature/splash/presentation/bloc/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc(
    this._diController,
    this._moduleConfigurators,
    this._onInitializationSuccessful,
  ) : super(SetUpProgressState.initial()) {
    on<OnInitEvent>(_onOnInitEventToState);
  }

  final DIController _diController;

  final List<ModuleConfigurator> _moduleConfigurators;

  final void Function(DesignSystem) _onInitializationSuccessful;

  final _receivedSetUpStatus = <DISetUpStatus>[];

  bool errorDuringDI = false;

  FutureOr<void> _onOnInitEventToState(
    OnInitEvent event,
    Emitter<SplashState> emit,
  ) async {
    await emit.onEach<DISetUpStatus>(
      _diController.setUpDIGraph(configurators: _moduleConfigurators),
      onData: (setUpStatus) {
        _receivedSetUpStatus.add(setUpStatus);
        final progress =
            _receivedSetUpStatus.length / DISetUpStatus.values.length;
        emit(SetUpProgressState(_receivedSetUpStatus, progress));
      },
      onError: (error, stackTrace) {
        errorDuringDI = true;
        if (error is DISetupException) {
          emit(SetUpErrorState(error.message ?? error.cause ?? error));
          return;
        }
        emit(SetUpErrorState(error));
      },
    );

    if (!errorDuringDI) {
      emit(const SetUpCompetedState(DesignSystem.primary));
      _onInitializationSuccessful(DesignSystem.primary);
    }
  }
}
