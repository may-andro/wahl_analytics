import 'dart:async';

import 'package:core/core.dart';
import 'package:use_case/use_case.dart';
import 'package:wahl_analytics/src/feature/locale/domain/repository/locale_repository.dart';

class UpdateLocaleFailure extends BasicFailure {
  const UpdateLocaleFailure({super.message, super.cause});
}

class UpdateLocaleUseCase
    extends BaseUseCase<void, AppLocale, UpdateLocaleFailure> {
  UpdateLocaleUseCase(this._localeRepository);

  final LocaleRepository _localeRepository;

  @override
  FutureOr<Either<UpdateLocaleFailure, void>> execute(AppLocale input) async {
    await _localeRepository.updateAppLocale(input);
    return const Right(null);
  }

  @override
  UpdateLocaleFailure mapErrorToFailure(Object e, StackTrace st) {
    return UpdateLocaleFailure(message: e.toString(), cause: e);
  }
}
