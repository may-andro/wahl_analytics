import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:meta/meta.dart';
import 'package:use_case/src/interceptor/use_case_interceptor_data_source.dart';
import 'package:use_case/src/model/failure.dart';

mixin UseCaseExecutionMixin<O, F extends Failure> {
  final _interceptors = UseCaseInterceptorDataSource.registeredInterceptorList;

  FutureOr<Either<F, O>> executeWithInterceptors({
    required String tag,
    required dynamic params,
    required FutureOr<Either<F, O>> Function() onExecute,
  }) {
    _notifyInterceptorsOnCall(tag, params);

    try {
      final result = onExecute();
      return result is Future<Either<F, O>>
          ? _handleAsyncExecution(result, tag)
          : _handleSyncExecution(result, tag);
    } catch (e, st) {
      return _doOnError(tag, e, st);
    }
  }

  // Abstract methods to be implemented by subclasses
  @protected
  F mapErrorToFailure(Object e, StackTrace st);

  /// Synchronous execution handling
  Either<F, O> _handleSyncExecution(Either<F, O> result, String tag) {
    _notifyInterceptorsOnSuccess(tag, result);
    return result;
  }

  /// Asynchronous execution handling
  Future<Either<F, O>> _handleAsyncExecution(
    Future<Either<F, O>> result,
    String tag,
  ) {
    return result
        .then((asyncResult) {
          _notifyInterceptorsOnSuccess(tag, asyncResult);
          return asyncResult;
        })
        .catchError((Object e, StackTrace st) => _doOnError(tag, e, st));
  }

  /// Handle errors and notify interceptors
  Left<F, O> _doOnError(String tag, Object e, StackTrace st) {
    final failure = mapErrorToFailure(e, st);
    _notifyInterceptorsOnError(tag, e, st);
    return Left(failure);
  }

  void _notifyInterceptorsOnCall(String tag, dynamic params) {
    for (final interceptor in _interceptors) {
      interceptor.onCall(tag, params);
    }
  }

  void _notifyInterceptorsOnSuccess(String tag, Either<F, O> result) {
    for (final interceptor in _interceptors) {
      interceptor.onSuccess(tag, result);
    }
  }

  void _notifyInterceptorsOnError(String tag, Object error, StackTrace st) {
    for (final interceptor in _interceptors) {
      interceptor.onError(tag, error, st);
    }
  }
}
