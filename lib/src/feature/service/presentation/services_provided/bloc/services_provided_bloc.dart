import 'dart:async';

import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wahl_analytics/src/feature/service/presentation/services_provided/bloc/services_provided_event.dart';
import 'package:wahl_analytics/src/feature/service/presentation/services_provided/bloc/services_provided_state.dart';

class ServicesProvidedBloc
    extends Bloc<ServicesProvidedEvent, ServicesProvidedState> {
  ServicesProvidedBloc() : super(const ServicesProvidedState()) {
    on<SetBusinessServiceEntityEvent>(
      _mapOnSetBusinessServiceEntityEventToState,
    );
  }

  FutureOr<void> _mapOnSetBusinessServiceEntityEventToState(
    SetBusinessServiceEntityEvent event,
    Emitter<ServicesProvidedState> emit,
  ) {
    emit(state.copyWith(viewState: DSViewState.idle, services: event.services));
  }
}
