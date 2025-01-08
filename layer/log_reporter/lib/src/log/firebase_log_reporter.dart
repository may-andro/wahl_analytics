import 'package:firebase/firebase.dart';
import 'package:log_reporter/src/log/log_reporter.dart';

class FirebaseLogReporter implements LogReporter {
  FirebaseLogReporter(this._fbCrashlyticsController);

  final FbCrashlyticsController _fbCrashlyticsController;

  @override
  void debug(
    String message, {
    String? tag,
    dynamic error,
    StackTrace? stacktrace,
  }) {
    _logMessage('[$tag] $message');
  }

  @override
  void error(
    String message, {
    String? tag,
    dynamic error,
    StackTrace? stacktrace,
  }) {
    _logMessage('[$tag] $message');
  }

  void _logMessage(String message) =>
      _fbCrashlyticsController.logMessage(message);
}
