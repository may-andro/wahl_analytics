import 'package:equatable/equatable.dart';
import 'package:feature_flag/feature_flag.dart';

sealed class FeatureFlagEvent extends Equatable {
  const FeatureFlagEvent();

  @override
  List<Object> get props => [];
}

final class OnInitScreenEvent extends FeatureFlagEvent {}

final class UpdateFFEvent extends FeatureFlagEvent {
  const UpdateFFEvent({required this.featureFlag});

  final FeatureFlag featureFlag;
}

final class ResetFFEvent extends FeatureFlagEvent {}

final class UpdateListTypeEvent extends FeatureFlagEvent {}

final class RestartAppEvent extends FeatureFlagEvent {}

final class UpdateSearchFieldVisibilityEvent extends FeatureFlagEvent {}

final class SearchTermUpdateEvent extends FeatureFlagEvent {
  const SearchTermUpdateEvent(this.searchTerm);

  final String searchTerm;
}

final class ScreenVisibleEvent extends FeatureFlagEvent {}
