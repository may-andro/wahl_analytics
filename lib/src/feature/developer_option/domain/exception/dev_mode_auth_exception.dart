import 'package:error_reporter/error_reporter.dart';

sealed class DevModeAuthException implements AppException {
  const DevModeAuthException(
    this.cause,
    this.stackTrace,
  );

  final Object cause;
  final StackTrace stackTrace;
}

class NullDevModeAuthDataException extends DevModeAuthException {
  const NullDevModeAuthDataException(
    super.cause,
    super.stackTrace,
  );

  @override
  String toString() => 'Null data found for Verification Codes at Firebase';
}

class DevModeAuthServerException extends DevModeAuthException {
  const DevModeAuthServerException(
    super.cause,
    super.stackTrace,
  );

  @override
  String toString() =>
      'Failed to fetch Verification Codes as firebase failed due to $cause';
}

class InvalidDevModeAuthJsonException extends DevModeAuthException {
  const InvalidDevModeAuthJsonException(
    super.cause,
    super.stackTrace,
  );

  @override
  String toString() =>
      'Failed to fetch Verification Codes as json structure is incorrect';
}

class UnknownDevModeAuthException extends DevModeAuthException {
  const UnknownDevModeAuthException(
    super.cause,
    super.stackTrace,
  );

  @override
  String toString() => 'Failed to fetch Verification Codes due to $cause';
}
