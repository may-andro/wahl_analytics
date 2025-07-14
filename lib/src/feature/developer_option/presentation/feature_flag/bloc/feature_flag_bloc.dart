import 'dart:async';

import 'package:design_system/design_system.dart';
import 'package:feature_flag/feature_flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wahl_analytics/src/app/restart_app.dart';
import 'package:wahl_analytics/src/feature/developer_option/presentation/feature_flag/bloc/feature_flag_event.dart';
import 'package:wahl_analytics/src/feature/developer_option/presentation/feature_flag/bloc/feature_flag_state.dart';
import 'package:wahl_analytics/src/feature/developer_option/presentation/feature_flag/tracking/feature_flag_tracking_delegate.dart';

class FeatureFlagBloc extends Bloc<FeatureFlagEvent, FeatureFlagState> {
  FeatureFlagBloc(
    this._getFeatureFlagsUseCase,
    this._updateFeatureFlagUseCase,
    this._resetFeatureFlagsUseCase,
    this._trackingDelegate,
  ) : super(
        FeatureFlagState(
          scrollController: ScrollController(),
          searchFocusNode: FocusNode(),
          searchTextEditingController: TextEditingController(),
        ),
      ) {
    on<OnInitScreenEvent>(_mapOnInitScreenEventToState);
    on<UpdateFFEvent>(_mapUpdateFFEventToState);
    on<ResetFFEvent>(_mapResetFFEventToState);
    on<UpdateListTypeEvent>(_mapUpdateListTypeEventToState);
    on<RestartAppEvent>(_mapRestartAppEventToState);
    on<UpdateSearchFieldVisibilityEvent>(
      _mapUpdateSearchFieldVisibilityEventToState,
    );
    on<SearchTermUpdateEvent>(_mapSearchTermUpdateEventToState);
    on<ScreenVisibleEvent>(_mapScreenVisibleEventToState);
  }

  final GetFeatureFlagsUseCase _getFeatureFlagsUseCase;
  final UpdateFeatureFlagUseCase _updateFeatureFlagUseCase;
  final ResetFeatureFlagsUseCase _resetFeatureFlagsUseCase;
  final FeatureFlagTrackingDelegate _trackingDelegate;

  FutureOr<void> _mapOnInitScreenEventToState(
    OnInitScreenEvent event,
    Emitter<FeatureFlagState> emit,
  ) async {
    final eitherResult = await _getFeatureFlagsUseCase();
    eitherResult.fold(
      (failure) {
        emit(state.copyWith(viewState: DSViewState.error));
      },
      (featureFlags) {
        emit(
          state.copyWith(
            viewState: DSViewState.idle,
            featureFlags: featureFlags,
          ),
        );
      },
    );
  }

  FutureOr<void> _mapUpdateFFEventToState(
    UpdateFFEvent event,
    Emitter<FeatureFlagState> emit,
  ) async {
    final eitherResult = await _updateFeatureFlagUseCase(event.featureFlag);
    eitherResult.fold(
      (failure) {
        //emit(state.copyWith(viewState: DSViewState.error));
      },
      (_) {
        final List<FeatureFlag> featureFlags = List.of(
          state.featureFlags ?? [],
        );
        if (featureFlags.isEmpty) return;

        final index = featureFlags.indexWhere(
          (featureFlag) => featureFlag.feature == event.featureFlag.feature,
        );
        if (index == -1) return;

        featureFlags[index] = event.featureFlag;
        emit(state.copyWith(featureFlags: featureFlags, isRestartNeeded: true));
      },
    );
  }

  FutureOr<void> _mapResetFFEventToState(
    ResetFFEvent event,
    Emitter<FeatureFlagState> emit,
  ) async {
    emit(state.copyWith(viewState: DSViewState.loading));

    final eitherResult = await _resetFeatureFlagsUseCase();
    eitherResult.fold(
      (failure) {
        //emit(state.copyWith(viewState: DSViewState.error));
      },
      (_) {
        state.copyWith(isRestartNeeded: true);
        add(OnInitScreenEvent());
      },
    );
  }

  FutureOr<void> _mapUpdateListTypeEventToState(
    UpdateListTypeEvent event,
    Emitter<FeatureFlagState> emit,
  ) {
    emit(state.copyWith(isGrid: !state.isGrid));
  }

  FutureOr<void> _mapRestartAppEventToState(
    RestartAppEvent event,
    Emitter<FeatureFlagState> emit,
  ) {
    return restartApp();
  }

  FutureOr<void> _mapUpdateSearchFieldVisibilityEventToState(
    UpdateSearchFieldVisibilityEvent event,
    Emitter<FeatureFlagState> emit,
  ) {
    final isSearchFieldVisible = !state.isSearchFieldVisible;
    if (isSearchFieldVisible) {
      state.searchFocusNode.requestFocus();
      emit(
        state.copyWith(
          searchTerm: state.searchTextEditingController.text.toLowerCase(),
          isSearchFieldVisible: isSearchFieldVisible,
        ),
      );
    } else {
      state.searchFocusNode.unfocus();
      state.searchTextEditingController.clear();
      emit(
        state.copyWith(
          searchTerm: state.searchTextEditingController.text,
          isSearchFieldVisible: isSearchFieldVisible,
        ),
      );
    }
  }

  FutureOr<void> _mapSearchTermUpdateEventToState(
    SearchTermUpdateEvent event,
    Emitter<FeatureFlagState> emit,
  ) {
    emit(state.copyWith(searchTerm: event.searchTerm));
  }

  FutureOr<void> _mapScreenVisibleEventToState(
    ScreenVisibleEvent event,
    Emitter<FeatureFlagState> emit,
  ) {
    _trackingDelegate.trackScreenView();
  }
}
