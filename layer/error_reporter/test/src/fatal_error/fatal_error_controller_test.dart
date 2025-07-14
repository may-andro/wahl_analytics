import 'dart:async';

import 'package:error_reporter/src/exception/fatal_exception.dart';
import 'package:error_reporter/src/exception/handler_registered_exception.dart';
import 'package:error_reporter/src/fatal_error/fatal_error_controller.dart';
import 'package:error_reporter/src/fatal_error/fatal_error_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class FakeFatalErrorHandler implements FatalErrorHandler {
  Object? error;

  @override
  FutureOr<void> onFatalError(Object object) {
    error = object;
  }
}

class MockFatalErrorHandler extends Mock implements FatalErrorHandler {}

class TestFatalException implements FatalException {}

void main() {
  group(FatalErrorController, () {
    late FatalErrorController controller;

    setUp(() {
      controller = FatalErrorController();
    });

    group('register', () {
      test('should register handlers', () {
        final handler1 = MockFatalErrorHandler();
        final handler2 = MockFatalErrorHandler();

        controller.register(handler1);
        controller.register(handler2);

        expect(controller.registeredHandlers, contains(handler1));
        expect(controller.registeredHandlers, contains(handler2));
        expect(controller.registeredHandlers.length, 2);
      });

      test('should not register duplicate handlers', () {
        final handler = MockFatalErrorHandler();

        controller.register(handler);

        expect(controller.registeredHandlers.length, 1);
        expect(
          () => controller.register(handler),
          throwsA(isA<HandlerRegisteredException>()),
        );
      });
    });

    group('registeredHandlers', () {
      test('should have no handlers by default', () {
        expect(controller.registeredHandlers.length, 0);
      });

      test('should return the register handlers', () {
        final handler = MockFatalErrorHandler();

        controller.register(handler);

        expect(controller.registeredHandlers.length, 1);
      });
    });

    group('isFatalError', () {
      test('should return true when error is type $Error', () {
        final result = controller.isFatalError(ArgumentError());

        expect(result, isTrue);
      });

      test('should return true when error is $FlutterError '
          '& does not contains RenderFlex keyword', () {
        final result = controller.isFatalError(FlutterError('Test'));

        expect(result, isTrue);
      });

      test('should return true when error is type $FatalException', () {
        final result = controller.isFatalError(TestFatalException());

        expect(result, isTrue);
      });

      test('should return false when error is $FlutterError '
          '& contains RenderFlex keyword', () {
        final result = controller.isFatalError(FlutterError('RenderFlex'));

        expect(result, isFalse);
      });

      test('should return false when error is type $Exception', () {
        final result = controller.isFatalError(Exception('RenderFlex'));

        expect(result, isFalse);
      });
    });

    group('onFatalError', () {
      test('should call onFatalError on all registered handlers', () async {
        final handler1 = FakeFatalErrorHandler();
        final handler2 = FakeFatalErrorHandler();
        final error = Exception('Test error');

        controller.register(handler1);
        controller.register(handler2);

        await controller.onFatalError(error);

        expect(handler1.error, error);
        expect(handler2.error, error);
      });
    });
  });
}
