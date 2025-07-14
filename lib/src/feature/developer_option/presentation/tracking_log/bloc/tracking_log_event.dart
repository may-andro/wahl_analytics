import 'package:equatable/equatable.dart';

sealed class TrackingLogEvent extends Equatable {
  const TrackingLogEvent();

  @override
  List<Object> get props => [];
}

final class OnInitEvent extends TrackingLogEvent {}

final class ScreenVisibleEvent extends TrackingLogEvent {}
