Error module centralise the error logic for the App. It handles the error/crash reporting for the system.

## Features

Following concept are provided by the module:
1. Defining error/exception
2. Blacklisting an error
3. Fatal Error Handler
4. Error Reporter

## Getting started

Import the module in the project in pubspec.yaml file.
```yaml
  error_reporter:
  path: layer/error_reporter
```

## Defining error/exception

The module exposes the base exception `AppException` which the app could use to keep the consistency of errors.

```dart
class BlacklistException implements AppException {}
```

It also allows the creation of fatal exception `FatalException`
```dart
class CustomFatalException implements FatalException {}
```

## Blacklisting an error

The module provide support to blacklist some error. Here are the steps required to blacklist a error.

### Create a concrete implementation of `BlacklistErrorHandler`

```dart
//Create your concrete implementation
class BlacklistErrorHandlerImpl implements BlacklistErrorHandler {
  @override
  bool isBlacklistError(Object error) {
    return error is BlacklistException;
  }
}
```

### Register the `BlacklistErrorHandler`

```dart
//Register your blacklist callback in the use case
final blacklistErrorController = serviceLocator.get<BlacklistErrorController>();
blacklistErrorController.register(BlacklistErrorHandlerImpl());
```

## Fatal Error Handler

The module provide support to provide functionality if a fatal error is encountered. Here are the steps required to handle fatal errors.

### Create a concrete implementation of `FatalErrorHandler`

```dart
//Create your concrete implementation
class FatalErrorHandlerImpl implements FatalErrorHandler {
  @override
  FutureOr<void> onFatalError(Object error) {
    exit(1);
  }
}
```

### Register the `FatalErrorHandler`

```dart
//Register your blacklist callback in the use case
final fatalErrorController = serviceLocator.get<FatalErrorController>();
fatalErrorController.register(FatalErrorHandlerImpl());
```

## Error Reporter

The module exposes `ErrorReporter` which could be used to handle the `FlutterError` and report errors to tools like `Crashlytics`.

```dart
//Access the ErrorReporter
final errorReporter = serviceLocator.get<ErrorReporter>();

//To report an error
errorReporter.reportError(exception: CustomFatalException(),stackTrace: StackTrace.current);
```
