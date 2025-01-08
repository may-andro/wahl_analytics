import 'package:equatable/equatable.dart';
import 'package:wahl_analytics/src/feature/home/domain/domain.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

final class OnInitScreenEvent extends HomeEvent {}

final class GetContentEvent extends HomeEvent {}

final class ContentScrollEvent extends HomeEvent {
  const ContentScrollEvent(this.selectedBodySection);

  final BodySection selectedBodySection;
}

final class TabSelectionEvent extends HomeEvent {
  const TabSelectionEvent(this.selectedBodySection);

  final BodySection selectedBodySection;
}

final class HeaderLogoClickEvent extends HomeEvent {}
