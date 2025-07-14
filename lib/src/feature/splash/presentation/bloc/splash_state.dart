import 'package:dependency_injection/dependency_injection.dart';
import 'package:design_system/design_system.dart';
import 'package:equatable/equatable.dart';

sealed class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

final class SetUpErrorState extends SplashState {
  const SetUpErrorState(this.cause);

  final Object? cause;
}

final class SetUpProgressState extends SplashState {
  const SetUpProgressState(this.setUpStatus, this.progress);

  factory SetUpProgressState.initial() => const SetUpProgressState([], 0);

  final List<DISetUpStatus> setUpStatus;
  final double progress;

  @override
  List<Object> get props => [setUpStatus, progress];
}

final class SetUpCompetedState extends SplashState {
  const SetUpCompetedState(this.designSystem);

  final DesignSystem designSystem;

  @override
  List<Object> get props => [designSystem];
}
