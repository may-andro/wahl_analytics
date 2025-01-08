import 'package:design_system/design_system.dart';
import 'package:equatable/equatable.dart';
import 'package:feature_flag/feature_flag.dart';
import 'package:flutter/material.dart';

class FeatureFlagState extends Equatable {
  const FeatureFlagState({
    required this.scrollController,
    required this.searchFocusNode,
    required this.searchTextEditingController,
    this.viewState = DSViewState.loading,
    this.featureFlags,
    this.searchTerm,
    this.isGrid = true,
    this.isRestartNeeded = false,
    this.isSearchFieldVisible = false,
  });

  final ScrollController scrollController;
  final FocusNode searchFocusNode;
  final TextEditingController searchTextEditingController;
  final DSViewState viewState;
  final List<FeatureFlag>? featureFlags;
  final String? searchTerm;
  final bool isGrid;
  final bool isRestartNeeded;
  final bool isSearchFieldVisible;

  @override
  List<Object?> get props => [
        viewState,
        featureFlags,
        searchTerm,
        isGrid,
        isRestartNeeded,
        isSearchFieldVisible,
      ];

  FeatureFlagState copyWith({
    DSViewState? viewState,
    List<FeatureFlag>? featureFlags,
    String? searchTerm,
    bool? isGrid,
    bool? isRestartNeeded,
    bool? isSearchFieldVisible,
  }) {
    return FeatureFlagState(
      scrollController: scrollController,
      searchFocusNode: searchFocusNode,
      searchTextEditingController: searchTextEditingController,
      viewState: viewState ?? this.viewState,
      featureFlags: featureFlags ?? this.featureFlags,
      searchTerm: searchTerm ?? this.searchTerm,
      isGrid: isGrid ?? this.isGrid,
      isRestartNeeded: isRestartNeeded ?? this.isRestartNeeded,
      isSearchFieldVisible: isSearchFieldVisible ?? this.isSearchFieldVisible,
    );
  }

  List<FeatureFlag>? get filteredFeatureFlags {
    final searchedTerm =
        (searchTerm ?? searchTextEditingController.text).toLowerCase().trim();
    return featureFlags
        ?.where(
          (featureFlag) =>
              featureFlag.feature.title.toLowerCase().contains(searchedTerm),
        )
        .toList();
  }
}
