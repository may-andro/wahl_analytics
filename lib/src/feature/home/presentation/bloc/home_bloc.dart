import 'dart:async';

import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:feature_flag/feature_flag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wahl_analytics/src/feature/developer_option/domain/domain.dart';
import 'package:wahl_analytics/src/feature/home/domain/domain.dart';
import 'package:wahl_analytics/src/feature/home/presentation/bloc/home_event.dart';
import 'package:wahl_analytics/src/feature/home/presentation/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(
    this._getHomeContentUseCase,
    this._isFeatureEnabledUseCase,
    this._isDevModeAuthenticatedUseCase,
    this._buildConfig,
  ) : super(const HomeState()) {
    on<OnInitScreenEvent>(_mapOnInitScreenEventToState);
    on<GetContentEvent>(_mapGetContentEventToState);
    on<ContentScrollEvent>(_mapContentScrollEventToState);
    on<TabSelectionEvent>(_mapTabSelectionEventToState);
    on<HeaderLogoClickEvent>(_mapHeaderLogoClickEventToState);
  }

  final GetHomeContentUseCase _getHomeContentUseCase;
  final IsFeatureEnabledUseCase _isFeatureEnabledUseCase;
  final IsDevModeAuthenticatedUseCase _isDevModeAuthenticatedUseCase;
  final BuildConfig _buildConfig;
  int lastHeaderLogoTapTimeStamp = 0;
  int headerLogoTapCount = 0;

  Future<bool> get _isMobileDetailVisible async {
    final eitherResult = await _isFeatureEnabledUseCase(
      Feature.mobileDetailVisibility,
    );
    return eitherResult.fold((_) => false, (isEnabled) => isEnabled);
  }

  Future<bool> get _isEmailDetailVisible async {
    final eitherResult = await _isFeatureEnabledUseCase(
      Feature.emailDetailVisibility,
    );
    return eitherResult.fold((_) => false, (isEnabled) => isEnabled);
  }

  Future<bool> get _isContactUsHomeFabVisible async {
    final eitherResult = await _isFeatureEnabledUseCase(
      Feature.contactUsHomeFab,
    );
    return eitherResult.fold((_) => false, (isEnabled) => isEnabled);
  }

  Future<bool> get _isServiceDetailEnabled async {
    final eitherResult = await _isFeatureEnabledUseCase(Feature.serviceDetail);
    return eitherResult.fold((_) => false, (isEnabled) => isEnabled);
  }

  FutureOr<void> _mapOnInitScreenEventToState(
    OnInitScreenEvent event,
    Emitter<HomeState> emit,
  ) async {
    final isContactUsHomeFabVisible = await _isContactUsHomeFabVisible;
    final isMobileDetailVisible = await _isMobileDetailVisible;
    final isEmailDetailVisible = await _isEmailDetailVisible;
    final isServiceDetailEnabled = await _isServiceDetailEnabled;
    emit(
      state.copyWith(
        viewState: DSViewState.loading,
        isContactUsFabVisible: isContactUsHomeFabVisible,
        isEmailDetailVisible: isEmailDetailVisible,
        isMobileDetailVisible: isMobileDetailVisible,
        isServiceDetailEnabled: isServiceDetailEnabled,
      ),
    );
    add(GetContentEvent());
  }

  FutureOr<void> _mapGetContentEventToState(
    GetContentEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(viewState: DSViewState.loading));

    final result = await _getHomeContentUseCase();
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            viewState: DSViewState.error,
            errorStateCause: failure.message,
          ),
        );
      },
      (homeContents) {
        final sectionKeysMap = <String, GlobalKey>{};
        final bodySection = homeContents.whereType<BodySection>().toList();
        for (final section in bodySection) {
          sectionKeysMap[section.name] = GlobalKey();
        }

        final newState = state.copyWith(
          viewState: DSViewState.idle,
          sections: homeContents,
          sectionKeyMap: sectionKeysMap,
          selectedBodySection: bodySection[0],
        );
        emit(newState);
      },
    );
  }

  FutureOr<void> _mapContentScrollEventToState(
    ContentScrollEvent event,
    Emitter<HomeState> emit,
  ) {
    emit(
      state.copyWith(
        selectedBodySection: event.selectedBodySection,
        scrollContentToSection: false,
      ),
    );
  }

  FutureOr<void> _mapTabSelectionEventToState(
    TabSelectionEvent event,
    Emitter<HomeState> emit,
  ) {
    emit(
      state.copyWith(
        selectedBodySection: event.selectedBodySection,
        scrollContentToSection: true,
      ),
    );
  }

  FutureOr<void> _mapHeaderLogoClickEventToState(
    HeaderLogoClickEvent event,
    Emitter<HomeState> emit,
  ) async {
    final newTriggerCount = state.devMenuTriggerCount + 1;

    if (_buildConfig.buildEnvironment.isDevMenuEnabled) {
      emit(
        state.copyWith(
          devMenuTriggerCount: newTriggerCount,
          isDevMenuEnabled: true,
        ),
      );
      return;
    }

    final eitherResult = await _isDevModeAuthenticatedUseCase();
    final showDevMenuAuthentication = eitherResult.fold(
      (failure) => false,
      (isAuthenticated) => isAuthenticated,
    );

    if (showDevMenuAuthentication) {
      emit(
        state.copyWith(
          devMenuTriggerCount: newTriggerCount,
          isDevMenuEnabled: true,
        ),
      );
      return;
    }

    final now = DateTime.now().millisecondsSinceEpoch;
    if (now - lastHeaderLogoTapTimeStamp < 1000) {
      headerLogoTapCount++;
      if (headerLogoTapCount == 3) {
        headerLogoTapCount = 0;
        emit(state.copyWith(devMenuTriggerCount: newTriggerCount));
      }
    } else {
      headerLogoTapCount = 0;
    }
    lastHeaderLogoTapTimeStamp = now;
  }
}
