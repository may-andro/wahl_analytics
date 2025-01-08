import 'package:error_reporter/error_reporter.dart';

sealed class ServiceException implements AppException {
  const ServiceException(
    this.cause,
    this.stackTrace,
  );

  final Object cause;
  final StackTrace stackTrace;
}

class NullDataFoundServiceException extends ServiceException {
  const NullDataFoundServiceException(
    super.cause,
    super.stackTrace,
  );

  @override
  String toString() => 'Null data found for BusinessService at Firebase';
}

class ServerServiceException extends ServiceException {
  const ServerServiceException(
    super.cause,
    super.stackTrace,
  );

  @override
  String toString() =>
      'Failed to fetch BusinessService as firebase failed due to $cause';
}

class IncorrectJsonServiceException extends ServiceException {
  const IncorrectJsonServiceException(
    super.cause,
    super.stackTrace,
  );

  @override
  String toString() =>
      'Failed to fetch BusinessService as json structure is incorrect';
}

class UnknownServiceException extends ServiceException {
  const UnknownServiceException(
    super.cause,
    super.stackTrace,
  );

  @override
  String toString() => 'Failed to fetch BusinessService due to $cause';
}
