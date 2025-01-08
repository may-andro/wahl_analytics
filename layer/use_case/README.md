UseCase module creates the base structure which each use case needs.

## Features

1. Supports various types of use cases: `sync`, `async` and `stream`.
2. Exposed `UseCaseInterceptor` which can be used to intercepts various phase of execution of use
   case.
3. Uses `Either` class concept. The Either class represents a type that can hold one of two possible
   values: `Success` or `Failure`.

## Getting started

Import the module in the project in pubspec.yaml file.

   ```yaml
   use_case:
     path: layer/use_case
   ```

## Usage

1. `UseCaseInterceptor`: This is an abstract for setting the interceptor for use case which can be
   used to monitor the different phases. For example:
   ```dart
    class LoggerUseCaseInterceptor implements UseCaseInterceptor {
      @override
      void onCall<Params>(String tag, Params params) {
        Log.log(tag, 'Called with ${params.toString()}');
      }
      
      @override
      void onError(String tag, Object error, StackTrace? stackTrace) {
        Log.error(tag, error, stackTrace);
      }
   
      @override
      void onSuccess<Type>(String tag, Type result) {
        Log.log(tag, 'Success with ${result.toString()}');
      }
   }
   ```
2. `UseCaseInterceptorController`: This class is used to register a `UseCaseInterceptor`.
3. There are two types of base use cases: `BaseUseCase` & `BaseNoParamUseCase`.
   Use `BaseNoParamUseCase` if there are no input params needed. For example:
   ```dart
   class FooUseCase extends BaseNoParamUseCase<int, FooUseCaseFailure> {
      @override
      FutureOr<Either<FooUseCaseFailure, int>> execute() {}
   }
   ```
   In case of input params, use `BaseSyncUseCase`. For example:
   ```dart
   class FooUseCase extends BaseSyncUseCase<int, Person, FooUseCaseFailure> {
      @override
      FutureOr<Either<FooUseCaseFailure, int>> execute(Person param) { {}
   }
   ```
4. `Failure`: A base class to define all kinds of failure during the execution of the use case. This
   approach restricts to use case for possible issues which can occur while execution and can be
   easily understood by presentation layer.
   ```dart
   sealed class FooUseCaseFailure extends BasicFailure {
      const FooUseCaseFailure({super.message, super.cause});
   }
   
   class EmptyFailure extends FooUseCaseFailure {
      const _UnknownFailure({super.message, super.cause});
   }
   ```

## Additional information

The module has following dependencies:

- [x] either_dart: ^0.3.0
- [x] equatable: ^2.0.3

