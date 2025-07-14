import 'package:dependency_injection/src/configurator/module_configurator.dart';
import 'package:dependency_injection/src/di_controller.dart';
import 'package:dependency_injection/src/model/di_setup_status.dart';
import 'package:dependency_injection/src/service_locator/get_it_service_locator.dart';
import 'package:dependency_injection/src/service_locator/service_locator.dart';
import 'package:flutter_test/flutter_test.dart';

class MockModuleConfigurator extends ModuleConfigurator {
  bool preDependenciesSetupCalled = false;
  bool registerDependenciesCalled = false;
  bool postDependenciesSetupCalled = false;

  @override
  Future<void> preDependenciesSetup(ServiceLocator serviceLocator) async {
    preDependenciesSetupCalled = true;
  }

  @override
  Future<void> registerDependencies(ServiceLocator serviceLocator) async {
    registerDependenciesCalled = true;
  }

  @override
  Future<void> postDependenciesSetup(ServiceLocator serviceLocator) async {
    postDependenciesSetupCalled = true;
  }
}

void main() {
  group(DIController, () {
    late DIController diController;
    late MockModuleConfigurator mockConfigurator;

    setUp(() {
      diController = DIController();
      mockConfigurator = MockModuleConfigurator();
    });

    group('serviceLocator', () {
      test('should initializes with default GetItServiceLocator', () {
        expect(diController.serviceLocator, isA<GetItServiceLocator>());
      });
    });

    group('setUpDIGraph', () {
      test(
        'should calls preDependenciesSetup, registerDependencies, and postDependenciesSetup',
        () async {
          final statuses = <DISetUpStatus>[];
          final stream = diController.setUpDIGraph(
            configurators: [mockConfigurator],
          );

          await for (final status in stream) {
            statuses.add(status);
          }

          expect(statuses, [
            DISetUpStatus.warmup,
            DISetUpStatus.fetch,
            DISetUpStatus.register,
            DISetUpStatus.done,
          ]);
          expect(mockConfigurator.preDependenciesSetupCalled, isTrue);
          expect(mockConfigurator.registerDependenciesCalled, isTrue);
          expect(mockConfigurator.postDependenciesSetupCalled, isTrue);
        },
      );

      test('should emits correct DISetUpStatus values', () async {
        final statuses = <DISetUpStatus>[];
        final stream = diController.setUpDIGraph(
          configurators: [mockConfigurator],
        );

        await for (final status in stream) {
          statuses.add(status);
        }

        expect(statuses, [
          DISetUpStatus.warmup,
          DISetUpStatus.fetch,
          DISetUpStatus.register,
          DISetUpStatus.done,
        ]);
      });
    });
  });
}
