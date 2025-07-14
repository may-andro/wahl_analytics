import 'package:error_reporter/error_reporter.dart';

sealed class ContactException implements AppException {
  const ContactException(this.cause, this.stackTrace);

  final Object cause;
  final StackTrace stackTrace;
}

class NullDataFoundContactException extends ContactException {
  const NullDataFoundContactException(super.cause, super.stackTrace);

  @override
  String toString() => 'Null data found for BusinessContact at Firebase';
}

class ServerContactException extends ContactException {
  const ServerContactException(super.cause, super.stackTrace);

  @override
  String toString() =>
      'Failed to fetch BusinessContact as firebase failed due to $cause';
}

class IncorrectJsonContactException extends ContactException {
  const IncorrectJsonContactException(super.cause, super.stackTrace);

  @override
  String toString() =>
      'Failed to fetch BusinessContact as json structure is incorrect';
}

class UnknownContactException extends ContactException {
  const UnknownContactException(super.cause, super.stackTrace);

  @override
  String toString() => 'Failed to fetch BusinessContact due to $cause';
}
