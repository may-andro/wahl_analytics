## Table of Contents

- [Getting Started](#getting-started)
- [Crashlytics](#crashlytics)
- [Analytics](#analytics)
- [Remote Config](#remote-config)
- [Storage](#storage)
- [Functions](#functions)
- [App Check](#app-check)

## Getting Started

This module is provides firebase capabilities like analytics, crashlytics and remote configs etc.

The module also initialises the firebase for the root project. All firebase initial setup is handled here.

Import the module in the project in pubspec.yaml file.
```yaml
  firebase:
    path: layer/firebase
```

To get started refer to `lib/src/dependency_injection/module_configurator.dart`. This is the entry point of the module.

`preSetUpModule`: This method is called to initialize the `Firebase` in the client project.
`setUpModule`: This methods setup the dependency graph for the module.
`postSetUpModule`: This methods exposed the post set functionality for the module. Features like `App Check`, `Analytics` and `Crashlytics` setups are done.

## Crashlytics

The module exposes `FbCrashlyticsController` which can be used for logging and crash reporting.

## Analytics

The module exposes `FbAnalyticsController` which can be used for sending events to `Firebase Analytics`.

To enable analytics debug mode on Android, run the following command in your terminal, while your
device(Android) is connected / Emulator is running.

```
adb shell setprop debug.firebase.analytics.app <project_id>
```

Refer to [docs](https://firebase.flutter.dev/docs/analytics/overview) for more info.

## Remote Config

The module exposes `FbRemoteConfigController` which can be used for getting and setting values of remote
configs.

## Storage

The module exposes `FbStorageController` which can be used for accessing firebase storage.

## Functions

The module exposes `FbFunctionController` which can be used for accessing firebase functions.

## App Check

The module has `FbAppCheckController` which can be used for setup for app check security. This feature is not exposed out at the moment but used internally.

