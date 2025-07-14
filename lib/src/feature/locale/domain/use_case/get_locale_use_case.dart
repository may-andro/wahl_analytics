import 'dart:async';

import 'package:core/core.dart';
import 'package:use_case/use_case.dart';
import 'package:wahl_analytics/src/feature/locale/domain/repository/locale_repository.dart';

class GetLocaleFailure extends BasicFailure {
  const GetLocaleFailure({super.message, super.cause});
}

class GetLocaleUseCase extends BaseNoParamUseCase<AppLocale, GetLocaleFailure> {
  GetLocaleUseCase(this._localeRepository);

  final LocaleRepository _localeRepository;

  @override
  FutureOr<Either<GetLocaleFailure, AppLocale>> execute() async {
    final appLocale = await _localeRepository.appLocale;
    return Right(appLocale);
  }

  @override
  GetLocaleFailure mapErrorToFailure(Object e, StackTrace st) {
    return GetLocaleFailure(message: e.toString(), cause: e);
  }
}
