import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/l10n/generated/app_localizations.dart';

class LocaleState extends Equatable {
  const LocaleState({
    this.viewState = DSViewState.loading,
    this.supportedLocales = AppLocalizations.supportedLocales,
    required this.appLocale,
  });

  final DSViewState viewState;
  final List<Locale> supportedLocales;
  final AppLocale appLocale;

  @override
  List<Object?> get props => [viewState, supportedLocales, appLocale];

  LocaleState copyWith({DSViewState? viewState, AppLocale? appLocale}) {
    return LocaleState(
      viewState: viewState ?? this.viewState,
      supportedLocales: supportedLocales,
      appLocale: appLocale ?? this.appLocale,
    );
  }
}
