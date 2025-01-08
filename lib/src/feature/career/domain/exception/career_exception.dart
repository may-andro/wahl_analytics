import 'package:error_reporter/error_reporter.dart';

sealed class CareerException implements AppException {
  const CareerException(
    this.cause,
    this.stackTrace,
  );

  final Object cause;
  final StackTrace stackTrace;
}

class UploadDocumentFailureException extends CareerException {
  const UploadDocumentFailureException(
    super.cause,
    super.stackTrace,
  );

  @override
  String toString() => 'Failed to upload document due to $cause';
}

class UnknownCareerException extends CareerException {
  const UnknownCareerException(
    super.cause,
    super.stackTrace,
  );

  @override
  String toString() => 'Failed to submit application due to $cause';
}
