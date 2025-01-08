## Overview

This Flutter module provides a robust and flexible mechanism for dependency injection using the `GetIt` package. The core functionality revolves around the `ServiceLocator` and `ModuleConfigurator` classes which help in setting up and managing dependencies within your application.

## Classes

### 1. `ModuleConfigurator`

The `ModuleConfigurator` class is an abstract class designed to facilitate the configuration and setup of dependencies. It includes three main methods:

- `preDependenciesSetup(ServiceLocator serviceLocator)`: This method is intended to perform any setup required before registering dependencies.
- `registerDependencies(ServiceLocator serviceLocator)`: This method registers all necessary dependencies.
- `postDependenciesSetup(ServiceLocator serviceLocator)`: This method handles any setup needed after dependencies have been registered.

```dart
abstract class ModuleConfigurator {
  FutureOr<void> preDependenciesSetup(ServiceLocator serviceLocator);
  FutureOr<void> registerDependencies(ServiceLocator serviceLocator);
  FutureOr<void> postDependenciesSetup(ServiceLocator serviceLocator);
}
```

### 2. `ServiceLocator`

The `ServiceLocator` interface defines the contract for a service locator, ensuring that any implementation provides the necessary methods for dependency management. 

`GetItServiceLocator` is an internal implementation of the ServiceLocator interface using GetIt as the underlying dependency injection mechanism.

### 3. `DIController`

The DIController class manages the setup of the dependency injection graph using a list of ModuleConfigurator instances. It provides a factory constructor for easy instantiation and a method to set up the dependency injection graph, emitting status updates as it progresses through the setup stages.

## Usage

To use this module in your Flutter project, follow these steps:

### 1.	Implement a `ModuleConfigurator`:

Create a class that extends ModuleConfigurator and implement the required methods:

```dart
class AppModuleConfigurator extends ModuleConfigurator {
  @override
  FutureOr<void> preDependenciesSetup(ServiceLocator serviceLocator) {
    // Perform pre-dependency setup here
  }

  @override
  FutureOr<void> registerDependencies(ServiceLocator serviceLocator) {
    serviceLocator.registerSingleton<SomeService>(() => SomeService());
  }

  @override
  FutureOr<void> postDependenciesSetup(ServiceLocator serviceLocator) {
    // Perform post-dependency setup here
  }
}
```

### 2.	Initialize the `Service Locator`:

Initialize and configure the service locator during your app’s startup:

```dart
void main() async {
  DIController().setUpDIGraph([AppModuleConfigurator()]);
}
```

### 3. Add the dependency in `pubspec.yaml`

```yaml
dependency_injection:
  path: layer/dependency_injection
```
