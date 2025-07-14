import 'package:cache/cache.dart';
import 'package:core/core.dart';
import 'package:dependency_injection/dependency_injection.dart';
import 'package:error_reporter/error_reporter.dart';
import 'package:feature_flag/feature_flag.dart';
import 'package:firebase/firebase.dart';
import 'package:log_reporter/log_reporter.dart';
import 'package:remote/remote.dart';
import 'package:tracking/tracking.dart';
import 'package:use_case/use_case.dart';
import 'package:wahl_analytics/src/dependency_injection/app_module_configurator.dart';
import 'package:wahl_analytics/src/feature/career/career.dart';
import 'package:wahl_analytics/src/feature/client/client.dart';
import 'package:wahl_analytics/src/feature/contact/contact.dart';
import 'package:wahl_analytics/src/feature/developer_option/developer_option.dart';
import 'package:wahl_analytics/src/feature/file_picker/file_picker.dart';
import 'package:wahl_analytics/src/feature/home/home.dart';
import 'package:wahl_analytics/src/feature/locale/locale.dart';
import 'package:wahl_analytics/src/feature/service/service.dart';
import 'package:wahl_analytics/src/feature/summary/summary.dart';
import 'package:wahl_analytics/src/feature/team/team.dart';
import 'package:wahl_analytics/src/feature/url_handler/url_handler.dart';
import 'package:wahl_analytics/src/feature/validation/validation.dart';
import 'package:wahl_analytics/src/route/route.dart';
import 'package:wahl_analytics/src/utility/utility_module_configurator.dart';

List<ModuleConfigurator> getModuleConfigurators(BuildConfig buildConfig) => [
  AppModuleConfigurator(buildConfig),
  FirebaseModuleConfigurator(buildConfig.buildEnvironment.isFirebaseEnabled),
  TrackingModuleConfigurator(
    buildConfig.buildEnvironment.isFirebaseEnabled,
  ),
  LogReporterModuleConfigurator(),
  UtilityModuleConfigurator(),
  RouteModuleConfigurator(),
  UseCaseModuleConfigurator(),
  ErrorReporterModuleConfigurator(
    buildConfig.buildEnvironment.isFirebaseEnabled,
  ),
  const CacheModuleConfigurator(),
  RemoteModuleConfigurator(
    buildConfig.buildEnvironment.isRemoteLoggingEnabled,
    '',
  ),
  FeatureFlagModuleConfigurator(),
  ValidationModuleConfigurator(),
  FilePickerModuleConfigurator(),
  UrlHandlerModuleConfigurator(),
  LocaleModuleConfigurator(),
  DeveloperOptionModuleConfigurator(),
  ServiceModuleConfigurator(),
  TeamModuleConfigurator(),
  ContactModuleConfigurator(),
  ClientModuleConfigurator(),
  SummaryModuleConfigurator(),
  HomeModuleConfigurator(),
  CareerModuleConfigurator(),
];
