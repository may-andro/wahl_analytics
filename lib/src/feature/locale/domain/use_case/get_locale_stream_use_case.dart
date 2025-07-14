import 'package:core/core.dart';
import 'package:wahl_analytics/src/feature/locale/domain/repository/locale_repository.dart';

class GetLocaleStreamUseCase {
  GetLocaleStreamUseCase(this._localeRepository);

  final LocaleRepository _localeRepository;

  Stream<AppLocale> call() {
    return _localeRepository.appLocaleStream;
  }
}
