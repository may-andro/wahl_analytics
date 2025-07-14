// ignore_for_file: avoid_redundant_argument_values
import 'dart:async';

import 'package:alchemist/alchemist.dart';
import 'package:flutter_test/flutter_test.dart';

///A common way to use this mechanic to configure tests for all your tests in a particular package is by using a flutter_test_config.dart file.
///This file is executed every time a test file is about to be run.
///Any test executed in the package will now use the provided config.

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  const isRunningInCi = bool.fromEnvironment('CI');
  const config = AlchemistConfig(
    platformGoldensConfig: PlatformGoldensConfig(enabled: !isRunningInCi),
  );

  TestWidgetsFlutterBinding.ensureInitialized();
  return AlchemistConfig.runWithConfig(config: config, run: testMain);
}
