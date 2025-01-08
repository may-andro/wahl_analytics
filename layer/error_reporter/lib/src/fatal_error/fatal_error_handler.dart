import 'dart:async';

abstract class FatalErrorHandler {
  FutureOr<void> onFatalError(Object error);
}
