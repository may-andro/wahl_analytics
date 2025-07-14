import 'package:log_reporter/log_reporter.dart';
import 'package:use_case/use_case.dart';

class LogUseCaseInterceptor implements UseCaseInterceptor {
  LogUseCaseInterceptor(this._logReporter);

  final LogReporter _logReporter;

  @override
  void onCall<Param>(String tag, Param param) {
    _logReporter.debug('Calling with params: $param', tag: tag);
  }

  @override
  void onError(String tag, Object error, StackTrace? stackTrace) {
    _logReporter.error(
      'Error detected: $error',
      tag: tag,
      error: error,
      stacktrace: stackTrace,
    );
  }

  @override
  void onSuccess<Type>(String tag, Type result) {
    _logReporter.debug('Success: ${result.runtimeType} $result', tag: tag);
  }
}
