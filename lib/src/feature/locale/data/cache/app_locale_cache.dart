import 'package:cache/cache.dart';
import 'package:core/core.dart';

class AppLocaleCache extends KeyValueCache<AppLocale> {
  AppLocaleCache() : super('app_locale_cache');

  @override
  AppLocale deserializeValue(Map<String, dynamic> map) {
    return AppLocale.fromJson(map);
  }

  @override
  Map<String, dynamic> serializeValue(AppLocale value) {
    return value.toJson();
  }
}
