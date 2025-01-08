import 'package:firebase_remote_config/firebase_remote_config.dart';

class FbRemoteConfigController {
  FbRemoteConfigController(this._firebaseRemoteConfig);

  final FirebaseRemoteConfig _firebaseRemoteConfig;

  Future<void> initialiseRemoteConfig() async {
    await _firebaseRemoteConfig.setDefaults(RemoteConfigs.defaultConfigsMap);
    await _firebaseRemoteConfig.fetchAndActivate();
  }

  RemoteConfigValue getValueForKey(String input) {
    return _firebaseRemoteConfig.getValue(input);
  }

  Map<String, RemoteConfigValue> getAllConfigsValue() {
    return _firebaseRemoteConfig.getAll();
  }
}

enum RemoteConfigs {
  contactUsHomeFab(key: 'contact_us_home_fab', defaultValue: 'false'),
  languageSwitcher(key: 'language_switcher', defaultValue: 'false'),
  mobileDetailVisibility(
    key: 'mobile_detail_visibility',
    defaultValue: 'false',
  ),
  emailDetailVisibility(
    key: 'email_detail_visibility',
    defaultValue: 'false',
  ),
  serviceDetail(key: 'service_detail', defaultValue: 'false'),
  ;

  const RemoteConfigs({
    required this.key,
    required this.defaultValue,
  });

  final String key;
  final dynamic defaultValue;

  static Map<String, dynamic> get defaultConfigsMap {
    final defaultConfigMap = <String, dynamic>{};
    for (final value in values) {
      defaultConfigMap[value.key] = value.defaultValue;
    }
    return defaultConfigMap;
  }
}
