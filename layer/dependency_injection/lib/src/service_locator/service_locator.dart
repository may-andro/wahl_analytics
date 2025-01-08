import 'dart:async';

abstract class ServiceLocator {
  T get<T extends Object>();

  void registerFactory<T extends Object>(
    T Function() factory, {
    bool shouldOverride,
  });

  void registerSingleton<T extends Object>(
    T Function() factory, {
    FutureOr<void> Function(T param)? dispose,
    bool shouldOverride,
  });

  bool isRegistered<T extends Object>();

  Future<void> unregister<T extends Object>();

  Future<void> reset();
}
