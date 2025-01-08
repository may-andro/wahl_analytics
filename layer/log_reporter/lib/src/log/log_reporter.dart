abstract class LogReporter {
  void debug(
    String message, {
    String? tag,
    dynamic error,
    StackTrace? stacktrace,
  });

  void error(
    String message, {
    String? tag,
    dynamic error,
    StackTrace? stacktrace,
  });
}
