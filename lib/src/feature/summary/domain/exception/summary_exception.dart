import 'package:error_reporter/error_reporter.dart';

sealed class SummaryException implements AppException {
  const SummaryException(
    this.cause,
    this.stackTrace,
  );

  final Object cause;
  final StackTrace stackTrace;
}

class NullDataFoundSummaryException extends SummaryException {
  const NullDataFoundSummaryException(
    super.cause,
    super.stackTrace,
  );

  @override
  String toString() => 'Null data found for BusinessSummary at Firebase';
}

class ServerSummaryException extends SummaryException {
  const ServerSummaryException(
    super.cause,
    super.stackTrace,
  );

  @override
  String toString() =>
      'Failed to fetch BusinessSummary as firebase failed due to $cause';
}

class IncorrectJsonSummaryException extends SummaryException {
  const IncorrectJsonSummaryException(
    super.cause,
    super.stackTrace,
  );

  @override
  String toString() =>
      'Failed to fetch BusinessSummary as json structure is incorrect';
}

class UnknownSummaryException extends SummaryException {
  const UnknownSummaryException(
    super.cause,
    super.stackTrace,
  );

  @override
  String toString() => 'Failed to fetch BusinessSummary due to $cause';
}
