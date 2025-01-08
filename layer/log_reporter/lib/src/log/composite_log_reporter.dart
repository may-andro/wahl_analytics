import 'package:log_reporter/src/log/log_reporter.dart';

class CompositeLogReporter implements LogReporter {
  CompositeLogReporter(this._logReporters);

  final List<LogReporter> _logReporters;

  @override
  void debug(
    String message, {
    String? tag,
    dynamic error,
    StackTrace? stacktrace,
  }) {
    for (final logReporter in _logReporters) {
      logReporter.debug(
        message,
        tag: tag,
        error: error,
        stacktrace: stacktrace,
      );
    }
  }

  @override
  void error(
    String message, {
    String? tag,
    dynamic error,
    StackTrace? stacktrace,
  }) {
    for (final logReporter in _logReporters) {
      logReporter.error(
        message,
        tag: tag,
        error: error,
        stacktrace: stacktrace,
      );
    }
  }
}
