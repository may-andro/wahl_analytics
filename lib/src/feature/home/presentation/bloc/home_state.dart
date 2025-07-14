import 'package:design_system/design_system.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/src/feature/home/domain/domain.dart';

class HomeState extends Equatable {
  const HomeState({
    this.viewState = DSViewState.loading,
    this.sections,
    this.sectionKeyMap,
    this.selectedBodySection,
    this.scrollContentToSection = false,
    this.isContactUsFabVisible = false,
    this.isMobileDetailVisible = false,
    this.isEmailDetailVisible = false,
    this.isServiceDetailEnabled = false,
    this.isDevMenuEnabled = false,
    this.devMenuTriggerCount = 0,
    this.errorStateCause,
  });

  final DSViewState viewState;
  final List<HomeContentEntity>? sections;
  final Map<String, GlobalKey>? sectionKeyMap;
  final BodySection? selectedBodySection;
  final bool scrollContentToSection;
  final bool isContactUsFabVisible;
  final bool isMobileDetailVisible;
  final bool isEmailDetailVisible;
  final bool isServiceDetailEnabled;
  final bool isDevMenuEnabled;
  final int devMenuTriggerCount;
  final String? errorStateCause;

  List<BodySection>? get homeBodySections {
    return sections?.whereType<BodySection>().toList();
  }

  @override
  List<Object?> get props => [
    viewState,
    sections,
    sectionKeyMap,
    selectedBodySection,
    scrollContentToSection,
    isContactUsFabVisible,
    isMobileDetailVisible,
    isEmailDetailVisible,
    isServiceDetailEnabled,
    isDevMenuEnabled,
    devMenuTriggerCount,
    errorStateCause,
  ];

  HomeState copyWith({
    DSViewState? viewState,
    List<HomeContentEntity>? sections,
    Map<String, GlobalKey>? sectionKeyMap,
    BodySection? selectedBodySection,
    bool? scrollContentToSection,
    bool? isContactUsFabVisible,
    bool? isMobileDetailVisible,
    bool? isEmailDetailVisible,
    bool? isServiceDetailEnabled,
    bool? isDevMenuEnabled,
    int? devMenuTriggerCount,
    String? errorStateCause,
  }) {
    return HomeState(
      viewState: viewState ?? this.viewState,
      sections: sections ?? this.sections,
      sectionKeyMap: sectionKeyMap ?? this.sectionKeyMap,
      selectedBodySection: selectedBodySection ?? this.selectedBodySection,
      scrollContentToSection:
          scrollContentToSection ?? this.scrollContentToSection,
      isContactUsFabVisible:
          isContactUsFabVisible ?? this.isContactUsFabVisible,
      isMobileDetailVisible:
          isMobileDetailVisible ?? this.isMobileDetailVisible,
      isEmailDetailVisible: isEmailDetailVisible ?? this.isEmailDetailVisible,
      isServiceDetailEnabled:
          isServiceDetailEnabled ?? this.isServiceDetailEnabled,
      isDevMenuEnabled: isDevMenuEnabled ?? this.isDevMenuEnabled,
      devMenuTriggerCount: devMenuTriggerCount ?? this.devMenuTriggerCount,
      errorStateCause: errorStateCause ?? this.errorStateCause,
    );
  }
}
