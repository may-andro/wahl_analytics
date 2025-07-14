import 'package:design_system/design_system.dart';
import 'package:equatable/equatable.dart';

class DevModeState extends Equatable {
  const DevModeState({this.viewState = DSViewState.idle});

  final DSViewState viewState;

  @override
  List<Object?> get props => [viewState];

  DevModeState copyWith({DSViewState? viewState}) {
    return DevModeState(viewState: viewState ?? this.viewState);
  }
}
