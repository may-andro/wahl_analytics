import 'package:flutter/cupertino.dart';
import 'package:wahl_analytics/l10n/generated/app_localizations.dart';

extension AppLocalizationsExtension on AppLocalizations {}

extension BuildContextLocalizationsExtension on BuildContext {
  AppLocalizations get localizations => AppLocalizations.of(this);

  String get locale => localizations.localeName;
}
