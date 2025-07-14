import 'package:error_reporter/error_reporter.dart';

sealed class TeamException implements AppException {
  const TeamException(this.cause, this.stackTrace);

  final Object cause;
  final StackTrace stackTrace;
}

class NullDataFoundTeamException extends TeamException {
  const NullDataFoundTeamException(super.cause, super.stackTrace);

  @override
  String toString() => 'Null data found for BusinessTeam at Firebase';
}

class ServerTeamException extends TeamException {
  const ServerTeamException(super.cause, super.stackTrace);

  @override
  String toString() =>
      'Failed to fetch BusinessTeam as firebase failed due to $cause';
}

class IncorrectJsonTeamException extends TeamException {
  const IncorrectJsonTeamException(super.cause, super.stackTrace);

  @override
  String toString() =>
      'Failed to fetch BusinessTeam as json structure is incorrect';
}

class UnknownTeamException extends TeamException {
  const UnknownTeamException(super.cause, super.stackTrace);

  @override
  String toString() => 'Failed to fetch BusinessTeam due to $cause';
}
