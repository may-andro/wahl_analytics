import 'package:flutter/material.dart';

class LocaleProviderWidget extends InheritedWidget {
  const LocaleProviderWidget({
    required this.locale,
    required super.child,
    super.key,
  });

  final Locale locale;

  @override
  bool updateShouldNotify(covariant LocaleProviderWidget oldWidget) {
    return locale != oldWidget.locale;
  }

  static Locale of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<LocaleProviderWidget>()!
        .locale;
  }
}
