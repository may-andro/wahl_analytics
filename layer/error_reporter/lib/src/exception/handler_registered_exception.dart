import 'package:error_reporter/src/exception/app_exception.dart';

class HandlerRegisteredException implements AppException {
  @override
  String toString() {
    return 'HandlerRegisteredException: The handler is already registered';
  }
}
