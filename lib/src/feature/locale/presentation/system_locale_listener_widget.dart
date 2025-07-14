import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:log_reporter/log_reporter.dart';
import 'package:wahl_analytics/src/dependency_injection/app_module_configurator.dart';
import 'package:wahl_analytics/src/feature/locale/domain/domain.dart';
import 'package:wahl_analytics/src/feature/locale/presentation/tracking/tracking.dart';

class SystemLocaleListenerWidget extends StatefulWidget {
  const SystemLocaleListenerWidget({required this.child, super.key});

  final Widget child;

  @override
  State<SystemLocaleListenerWidget> createState() =>
      _SystemLocaleListenerWidgetState();
}

class _SystemLocaleListenerWidgetState extends State<SystemLocaleListenerWidget>
    with WidgetsBindingObserver {
  late final LogReporter _logReporter;
  late final LocaleTrackingDelegate _trackingDelegate;
  late AppLocale _currentAppLocale;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _logReporter = appServiceLocator.get<LogReporter>();
    _currentAppLocale = appServiceLocator.get<AppLocale>();
    _trackingDelegate = appServiceLocator.get<LocaleTrackingDelegate>();
  }

  @override
  void didChangeLocales(List<Locale>? locales) {
    super.didChangeLocales(locales);

    final newLocale = locales?.first.appLocale;
    if (newLocale != null && newLocale != _currentAppLocale) {
      final updateLocaleUseCase = appServiceLocator.get<UpdateLocaleUseCase>();
      updateLocaleUseCase(newLocale);
      _currentAppLocale = newLocale;

      _logReporter.debug(
        'App locale updated to ${_currentAppLocale.languageCode}',
        tag: 'LocaleListenerWidget',
      );
      _trackingDelegate.trackUpdateLocaleClick(_currentAppLocale);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
