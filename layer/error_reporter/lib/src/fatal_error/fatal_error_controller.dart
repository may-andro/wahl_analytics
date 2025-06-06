import 'package:error_reporter/src/exception/fatal_exception.dart';
import 'package:error_reporter/src/exception/handler_registered_exception.dart';
import 'package:error_reporter/src/fatal_error/fatal_error_handler.dart';
import 'package:flutter/material.dart';

class FatalErrorController {
  final List<FatalErrorHandler> _handlers = [];

  void register(FatalErrorHandler handler) {
    if (_handlers.contains(handler)) {
      throw HandlerRegisteredException();
    }
    _handlers.add(handler);
  }

  List<FatalErrorHandler> get registeredHandlers => _handlers;

  bool isFatalError(Object error) {
    if (error is FlutterError && error.toString().contains('RenderFlex')) {
      return false;
    }

    return error is Error || error is FatalException;
  }

  Future<void> onFatalError(Object error) {
    return Future.forEach(
      registeredHandlers,
      (handler) => handler.onFatalError(error),
    );
  }
}
