import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:meta/meta.dart';
import 'package:use_case/src/model/failure.dart';
import 'package:use_case/src/use_case/use_case_mixin.dart';

abstract class BaseUseCase<O, I, F extends Failure>
    with UseCaseExecutionMixin<O, F> {
  FutureOr<Either<F, O>> call(I input) {
    return executeWithInterceptors(
      tag: _tag,
      params: input,
      onExecute: () => execute(input),
    );
  }

  @protected
  FutureOr<Either<F, O>> execute(I input);

  String get _tag => '${runtimeType}_${DateTime.now().microsecondsSinceEpoch}';
}
