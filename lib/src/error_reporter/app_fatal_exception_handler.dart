import 'dart:async';
import 'dart:io';

import 'package:error_reporter/error_reporter.dart';

class AppFatalErrorHandler implements FatalErrorHandler {
  @override
  FutureOr<void> onFatalError(Object error) {
    exit(1);
  }
}
