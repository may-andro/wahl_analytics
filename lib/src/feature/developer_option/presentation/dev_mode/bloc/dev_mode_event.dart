import 'package:equatable/equatable.dart';

sealed class DevModeEvent extends Equatable {
  const DevModeEvent();

  @override
  List<Object> get props => [];
}

final class OpenDBCacheScreenEvent extends DevModeEvent {}
