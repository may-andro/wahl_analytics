import 'dart:async';

import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wahl_analytics/src/feature/locale/domain/domain.dart';
import 'package:wahl_analytics/src/feature/locale/presentation/bloc/locale_event.dart';
import 'package:wahl_analytics/src/feature/locale/presentation/bloc/locale_state.dart';
import 'package:wahl_analytics/src/feature/locale/presentation/tracking/tracking.dart';

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  LocaleBloc(
    AppLocale appLocale,
    this._getLocaleUseCase,
    this._updateLocaleUseCase,
    this._trackingDelegate,
  ) : super(LocaleState(appLocale: appLocale)) {
    on<OnInitEvent>(_mapOnInitEventToState);
    on<LocaleClickEvent>(_mapLocaleClickEventToState);
    on<UpdateLocaleEvent>(_mapUpdateLocaleEventToState);
    on<PopupVisibleEvent>(_mapPopupVisibleEventToState);
  }

  final GetLocaleUseCase _getLocaleUseCase;
  final UpdateLocaleUseCase _updateLocaleUseCase;
  final LocaleTrackingDelegate _trackingDelegate;

  FutureOr<void> _mapOnInitEventToState(
    OnInitEvent event,
    Emitter<LocaleState> emit,
  ) async {
    final localeEither = await _getLocaleUseCase();
    localeEither.fold(
      (left) {
        emit(state.copyWith(viewState: DSViewState.error));
      },
      (right) {
        emit(state.copyWith(viewState: DSViewState.idle, appLocale: right));
      },
    );
  }

  FutureOr<void> _mapUpdateLocaleEventToState(
    UpdateLocaleEvent event,
    Emitter<LocaleState> emit,
  ) async {
    final appLocale = event.updatedLocale.appLocale;
    final eitherResult = await _updateLocaleUseCase(appLocale);
    eitherResult.fold(
      (left) {
        emit(state.copyWith(viewState: DSViewState.error));
      },
      (right) {
        _trackingDelegate.trackUpdateLocaleClick(appLocale);
        emit(state.copyWith(appLocale: appLocale));
      },
    );
  }

  FutureOr<void> _mapLocaleClickEventToState(
    LocaleClickEvent event,
    Emitter<LocaleState> emit,
  ) {
    final appLocale = state.appLocale;
    if (appLocale case final AppLocale appLocale) {
      _trackingDelegate.trackLocaleClick(appLocale);
    }
  }

  FutureOr<void> _mapPopupVisibleEventToState(
    PopupVisibleEvent event,
    Emitter<LocaleState> emit,
  ) {
    _trackingDelegate.trackLocalePopupView();
  }
}

extension ContextExtension on BuildContext {
  LocaleBloc get bloc => read<LocaleBloc>();

  LocaleState get state => bloc.state;
}
