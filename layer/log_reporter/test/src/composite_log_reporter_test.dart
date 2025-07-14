import 'package:flutter_test/flutter_test.dart';
import 'package:log_reporter/src/log/composite_log_reporter.dart';
import 'package:log_reporter/src/log/log_reporter.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group(CompositeLogReporter, () {
    late CompositeLogReporter compositeLogReporter;

    late _MockLogger1 mockLogger1;
    late _MockLogger2 mockLogger2;

    setUp(() {
      mockLogger1 = _MockLogger1();
      mockLogger2 = _MockLogger2();

      compositeLogReporter = CompositeLogReporter([mockLogger1, mockLogger2]);
    });

    group('debug', () {
      test('should call debug in each $LogReporter', () {
        compositeLogReporter.debug('test');

        verify(() => mockLogger1.debug('test')).called(1);
        verify(() => mockLogger2.debug('test')).called(1);
      });
    });

    group('error', () {
      test('should call error in each $LogReporter', () {
        compositeLogReporter.error('test');

        verify(() => mockLogger1.error('test')).called(1);
        verify(() => mockLogger2.error('test')).called(1);
      });
    });
  });
}

class _MockLogger1 extends Mock implements LogReporter {}

class _MockLogger2 extends Mock implements LogReporter {}
