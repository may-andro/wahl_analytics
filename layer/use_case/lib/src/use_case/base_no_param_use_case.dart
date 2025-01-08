import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:meta/meta.dart';
import 'package:use_case/src/model/failure.dart';
import 'package:use_case/src/use_case/use_case_mixin.dart';

abstract class BaseNoParamUseCase<O, F extends Failure>
    with UseCaseExecutionMixin<O, F> {
  FutureOr<Either<F, O>> call() {
    return executeWithInterceptors(
      tag: _tag,
      params: null,
      onExecute: () => execute(),
    );
  }

  @protected
  FutureOr<Either<F, O>> execute();

  String get _tag => '${runtimeType}_${DateTime.now().microsecondsSinceEpoch}';
}
