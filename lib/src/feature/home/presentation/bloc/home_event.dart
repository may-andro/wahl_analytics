import 'package:equatable/equatable.dart';
import 'package:wahl_analytics/src/feature/home/domain/domain.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

final class OnInitEvent extends HomeEvent {}

final class ScreenVisibleEvent extends HomeEvent {}

final class LoadingContentViewEvent extends HomeEvent {}

final class HomeContentViewEvent extends HomeEvent {}

final class ErrorContentViewEvent extends HomeEvent {}

final class HomeServiceSectionViewEvent extends HomeEvent {}

final class HomeClientSectionViewEvent extends HomeEvent {}

final class HomeTeamSectionViewEvent extends HomeEvent {}

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

final class ContactUsClickEvent extends HomeEvent {}

final class JoinUsClickEvent extends HomeEvent {}

final class DrawerEvent extends HomeEvent {
  const DrawerEvent(this.isOpened);

  final bool isOpened;
}
