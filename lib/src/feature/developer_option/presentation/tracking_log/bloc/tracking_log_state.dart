import 'package:design_system/design_system.dart';
import 'package:equatable/equatable.dart';
import 'package:tracking/tracking.dart';

class TrackingLogState extends Equatable {
  const TrackingLogState({
    this.viewState = DSViewState.loading,
    this.trackingLogs,
  });

  final DSViewState viewState;
  final Map<DateTime, Tracking>? trackingLogs;

  @override
  List<Object?> get props => [viewState, trackingLogs];

  TrackingLogState copyWith({
    DSViewState? viewState,
    Map<DateTime, Tracking>? trackingLogs,
  }) {
    return TrackingLogState(
      viewState: viewState ?? this.viewState,
      trackingLogs: trackingLogs ?? this.trackingLogs,
    );
  }
}
