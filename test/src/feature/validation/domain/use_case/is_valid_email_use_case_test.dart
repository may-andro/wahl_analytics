import 'package:flutter_test/flutter_test.dart';
import 'package:wahl_analytics/src/feature/validation/domain/domain.dart';

void main() {
  group('IsValidEmailUseCase', () {
    late IsValidEmailUseCase useCase;

    setUp(() {
      useCase = IsValidEmailUseCase();
    });

    test('should return NullEmailFailure when input is null', () async {
      final result = await useCase(null);

      expect(result.isLeft, isTrue);
      expect(result.left, isA<NullEmailFailure>());
    });

    test('should return EmptyEmailFailure when input is empty', () async {
      final result = await useCase('');

      expect(result.isLeft, isTrue);
      expect(result.left, isA<EmptyEmailFailure>());
    });

    test('should return true when email address is valid', () async {
      final result = await useCase('test@example.com');

      expect(result.isRight, isTrue);
      expect(result.right, isTrue);
    });

    test('should return false when email address is invalid (missing @)',
        () async {
      final result = await useCase('testexample.com');

      expect(result.isRight, isTrue);
      expect(result.right, isFalse);
    });

    test('should return false when email address is invalid (missing domain)',
        () async {
      final result = await useCase('test@.com');

      expect(result.isRight, isTrue);
      expect(result.right, isFalse);
    });

    test('should return false when email address is invalid (missing TLD)',
        () async {
      final result = await useCase('test@example');

      expect(result.isRight, isTrue);
      expect(result.right, isFalse);
    });

    test(
        'should return false when email address is invalid (invalid characters)',
        () async {
      final result = await useCase('test@exa mple.com');

      expect(result.isRight, isTrue);
      expect(result.right, isFalse);
    });

    test('should return false when email address is invalid (multiple @)',
        () async {
      final result = await useCase('test@@example.com');

      expect(result.isRight, isTrue);
      expect(result.right, isFalse);
    });
  });
}
