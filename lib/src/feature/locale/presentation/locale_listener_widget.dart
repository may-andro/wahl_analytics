import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:log_reporter/log_reporter.dart';
import 'package:wahl_analytics/src/dependency_injection/app_module_configurator.dart';
import 'package:wahl_analytics/src/feature/locale/presentation/locale_provider_widget.dart';

class LocaleListenerWidget extends StatefulWidget {
  const LocaleListenerWidget({
    required this.appLocale,
    required this.child,
    super.key,
  });

  final AppLocale appLocale;
  final Widget child;

  @override
  State<LocaleListenerWidget> createState() => _LocaleListenerWidgetState();
}

class _LocaleListenerWidgetState extends State<LocaleListenerWidget>
    with WidgetsBindingObserver {
  late final LogReporter _logReporter;
  late AppLocale _currentAppLocale;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _logReporter = appServiceLocator.get<LogReporter>();

    _currentAppLocale = widget.appLocale;
  }

  @override
  void didChangeLocales(List<Locale>? locales) {
    super.didChangeLocales(locales);

    final currentLocale = locales?.first;
    if (currentLocale != null &&
        currentLocale.languageCode != _currentAppLocale.locale) {
      _currentAppLocale = AppLocale(currentLocale.languageCode);

      appServiceLocator.unregister<AppLocale>();
      appServiceLocator.registerSingleton(() => _currentAppLocale);

      _logReporter.debug(
        'App locale updated to ${currentLocale.languageCode}',
        tag: 'LocaleListenerWidget',
      );

      setState(() {});
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LocaleProviderWidget(
      locale: Locale(_currentAppLocale.locale),
      child: widget.child,
    );
  }
}
