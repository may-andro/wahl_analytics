import 'dart:async';

import 'package:dependency_injection/src/service_locator/service_locator.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

final _getIt = GetIt.asNewInstance();

@internal
class GetItServiceLocator implements ServiceLocator {
  const GetItServiceLocator();

  @override
  T get<T extends Object>() => _getIt.get<T>();

  @override
  void registerFactory<T extends Object>(
    T Function() factory, {
    bool shouldOverride = false,
  }) {
    if (shouldOverride && isRegistered<T>()) {
      unregister<T>();
    }
    _getIt.registerFactory<T>(factory);
  }

  @override
  void registerSingleton<T extends Object>(
    T Function() factory, {
    FutureOr<void> Function(T param)? dispose,
    bool shouldOverride = false,
  }) {
    if (shouldOverride && isRegistered<T>()) {
      unregister<T>();
    }
    _getIt.registerLazySingleton<T>(factory, dispose: dispose);
  }

  @override
  bool isRegistered<T extends Object>() => _getIt.isRegistered<T>();

  @override
  Future<void> unregister<T extends Object>() async {
    await _getIt.unregister<T>();
  }

  @override
  Future<void> reset() => _getIt.reset();
}
