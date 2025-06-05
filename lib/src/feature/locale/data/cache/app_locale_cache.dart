import 'package:cache/cache.dart';

class AppLocaleCache extends KeyValueCache<String> {
  AppLocaleCache() : super('test_cache');

  @override
  String deserializeValue(Map<String, dynamic> map) {
    return map['locale'] as String;
  }

  @override
  Map<String, dynamic> serializeValue(String value) {
    return {'locale': value};
  }
}
