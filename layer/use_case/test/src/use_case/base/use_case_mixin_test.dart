import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:use_case/src/interceptor/use_case_interceptor.dart';
import 'package:use_case/src/interceptor/use_case_interceptor_controller.dart';
import 'package:use_case/src/model/failure.dart';
import 'package:use_case/src/use_case/base_no_param_use_case.dart';
import 'package:use_case/src/use_case/base_use_case.dart';

class MockUseCaseInterceptor extends Mock implements UseCaseInterceptor {}

class FakeFailure extends Failure {}

class FakeUseCase extends BaseUseCase<String, String, FakeFailure> {
  FakeUseCase({this.shouldThrow = false});

  final bool shouldThrow;

  @override
  FutureOr<Either<FakeFailure, String>> execute(String input) {
    if (shouldThrow) throw Exception('Error');
    return Right('Success: $input');
  }

  @override
  FakeFailure mapErrorToFailure(Object e, StackTrace st) {
    return FakeFailure();
  }
}

class FakeNoParamUseCase extends BaseNoParamUseCase<String, FakeFailure> {
  FakeNoParamUseCase({this.shouldThrow = false});

  final bool shouldThrow;

  @override
  FutureOr<Either<FakeFailure, String>> execute() {
    if (shouldThrow) throw Exception('Error');
    return const Right('Success');
  }

  @override
  FakeFailure mapErrorToFailure(Object e, StackTrace st) {
    return FakeFailure();
  }
}

void main() {
  group('UseCaseExecutionMixin', () {
    late MockUseCaseInterceptor mockInterceptor;

    setUp(() {
      mockInterceptor = MockUseCaseInterceptor();

      UseCaseInterceptorController().register(mockInterceptor);
    });

    group('BaseUseCase', () {
      test('calls interceptors on success', () async {
        final useCase = FakeUseCase();

        final result = await useCase('input_data');

        expect(result.isRight, isTrue);
        verify(
          () => mockInterceptor.onCall<dynamic>(any(), 'input_data'),
        ).called(1);
        verify(() => mockInterceptor.onSuccess(any(), result)).called(1);
        verifyNever(() => mockInterceptor.onError(any(), any(), any()));
      });

      test('calls interceptors on error', () async {
        final useCase = FakeUseCase(shouldThrow: true);

        final result = await useCase.call('input_data');

        expect(result.isLeft, isTrue);
        verify(
          () => mockInterceptor.onCall<dynamic>(any(), 'input_data'),
        ).called(1);
        verify(() => mockInterceptor.onError(any(), any(), any())).called(1);
        verifyNever(() => mockInterceptor.onSuccess(any(), any<dynamic>()));
      });
    });

    group('BaseNoParamUseCase', () {
      test('calls interceptors on success', () async {
        final noParamUseCase = FakeNoParamUseCase();

        final result = await noParamUseCase.call();

        expect(result.isRight, isTrue);
        verify(() => mockInterceptor.onCall<dynamic>(any(), null)).called(1);
        verify(() => mockInterceptor.onSuccess(any(), result)).called(1);
        verifyNever(() => mockInterceptor.onError(any(), any(), any()));
      });

      test('calls interceptors on error', () async {
        final noParamUseCase = FakeNoParamUseCase(shouldThrow: true);

        final result = await noParamUseCase.call();

        expect(result.isLeft, isTrue);
        verify(() => mockInterceptor.onCall<dynamic>(any(), null)).called(1);
        verify(() => mockInterceptor.onError(any(), any(), any())).called(1);
        verifyNever(() => mockInterceptor.onSuccess(any(), any<dynamic>()));
      });
    });
  });
}
