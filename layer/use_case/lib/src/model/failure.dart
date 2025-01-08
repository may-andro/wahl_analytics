import 'package:equatable/equatable.dart';

abstract class Failure {}

abstract class BasicFailure extends Equatable implements Failure {
  const BasicFailure({this.message, this.cause});

  final String? message;

  final Object? cause;

  String get _typeString => runtimeType.toString();

  @override
  String toString() {
    final message = this.message;
    final cause = this.cause;
    return <String>[
      _typeString,
      if (message != null) ': $message',
      if (cause != null) '. Caused by: $cause',
    ].join();
  }

  @override
  List<Object?> get props => [message, cause];

  @override
  bool? get stringify => null;
}

class NoFailure implements Failure {}

class UnknownFailure extends BasicFailure {
  const UnknownFailure({super.message, super.cause});
}
