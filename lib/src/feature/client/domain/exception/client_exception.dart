import 'package:error_reporter/error_reporter.dart';

sealed class ClientException implements AppException {
  const ClientException(
    this.cause,
    this.stackTrace,
  );

  final Object cause;
  final StackTrace stackTrace;
}

class NullDataFoundClientException extends ClientException {
  const NullDataFoundClientException(
    super.cause,
    super.stackTrace,
  );

  @override
  String toString() => 'Null data found for BusinessClient at Firebase';
}

class ServerClientException extends ClientException {
  const ServerClientException(
    super.cause,
    super.stackTrace,
  );

  @override
  String toString() =>
      'Failed to fetch BusinessClient as firebase failed due to $cause';
}

class IncorrectJsonClientException extends ClientException {
  const IncorrectJsonClientException(
    super.cause,
    super.stackTrace,
  );

  @override
  String toString() =>
      'Failed to fetch BusinessClient as json structure is incorrect';
}

class UnknownClientException extends ClientException {
  const UnknownClientException(
    super.cause,
    super.stackTrace,
  );

  @override
  String toString() => 'Failed to fetch BusinessClient due to $cause';
}
