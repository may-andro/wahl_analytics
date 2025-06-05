import 'dart:async';

import 'package:use_case/use_case.dart';
import 'package:wahl_analytics/src/feature/locale/data/data.dart';

class UpdateCacheFailure extends BasicFailure {
  const UpdateCacheFailure({super.message, super.cause});
}

class UpdateLocaleCacheUseCase
    extends BaseUseCase<bool, String, UpdateCacheFailure> {
  UpdateLocaleCacheUseCase(this._appLocaleCache);

  final AppLocaleCache _appLocaleCache;

  @override
  FutureOr<Either<UpdateCacheFailure, bool>> execute(String input) async {
    final isCached = await _appLocaleCache.put(input);
    return Right(isCached);
  }

  @override
  UpdateCacheFailure mapErrorToFailure(Object e, StackTrace st) {
    return UpdateCacheFailure(message: e.toString(), cause: e);
  }
}
