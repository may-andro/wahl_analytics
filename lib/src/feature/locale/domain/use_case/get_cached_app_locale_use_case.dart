import 'dart:async';

import 'package:core/core.dart';
import 'package:use_case/use_case.dart';
import 'package:wahl_analytics/src/feature/locale/data/data.dart';

class GetAppLocaleCacheFailure extends BasicFailure {
  const GetAppLocaleCacheFailure({super.message, super.cause});
}

class GetCachedAppLocaleUseCase
    extends BaseNoParamUseCase< AppLocale, GetAppLocaleCacheFailure> {
  GetCachedAppLocaleUseCase(this._appLocaleCache);

  final AppLocaleCache _appLocaleCache;

  @override
  FutureOr<Either<GetAppLocaleCacheFailure, AppLocale>> execute() async {
    final locale = await _appLocaleCache.get();
    if(locale == null) {
      return const Left(GetAppLocaleCacheFailure());
    }

    final appLocale = AppLocale(locale);
    return Right(appLocale);
  }

  @override
  GetAppLocaleCacheFailure mapErrorToFailure(Object e, StackTrace st) {
    return GetAppLocaleCacheFailure(message: e.toString(), cause: e);
  }

}
