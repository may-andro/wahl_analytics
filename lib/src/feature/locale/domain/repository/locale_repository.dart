import 'package:core/core.dart';

abstract class LocaleRepository {
  Stream<AppLocale> get appLocaleStream;

  Future<AppLocale> get appLocale;

  Future<void> updateAppLocale(AppLocale appLocale);
}
