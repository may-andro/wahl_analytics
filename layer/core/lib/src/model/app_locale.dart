import 'dart:ui';

class AppLocale {
  AppLocale(this.languageCode);

  factory AppLocale.fallback() {
    return AppLocale('en');
  }

  factory AppLocale.fromJson(Map<String, dynamic> json) {
    return AppLocale(json['languageCode'] as String);
  }

  final String languageCode;

  Map<String, dynamic> toJson() {
    return {'languageCode': languageCode};
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppLocale &&
          runtimeType == other.runtimeType &&
          languageCode == other.languageCode;

  @override
  int get hashCode => languageCode.hashCode;

  @override
  String toString() => 'AppLocale(languageCode: $languageCode)';
}

extension AppLocaleExtension on AppLocale {
  Locale get locale => Locale(languageCode);
}

extension LocaleExtension on Locale {
  AppLocale get appLocale => AppLocale(languageCode);
}
