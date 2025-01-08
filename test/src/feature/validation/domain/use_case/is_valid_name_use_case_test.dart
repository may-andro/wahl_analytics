import 'package:flutter_test/flutter_test.dart';
import 'package:wahl_analytics/src/feature/validation/domain/domain.dart';

void main() {
  group('IsValidNameUseCase', () {
    late IsValidNameUseCase useCase;

    setUp(() {
      useCase = IsValidNameUseCase();
    });

    test('should return NullNameFailure when input is null', () async {
      final result = await useCase(null);

      expect(result.isLeft, isTrue);
      expect(result.left, isA<NullNameFailure>());
    });

    test('should return EmptyNameFailure when input is empty', () async {
      final result = await useCase('');

      expect(result.isLeft, isTrue);
      expect(result.left, isA<EmptyNameFailure>());
    });

    test('should return true when name is alphabetic characters', () async {
      final result = await useCase('John Doe');

      expect(result.isRight, isTrue);
      expect(result.right, isTrue);
    });

    test('should return true when name has valid special characters', () async {
      final specialSpecialResult = await useCase("O'Connor");

      expect(specialSpecialResult.isRight, isTrue);
      expect(specialSpecialResult.right, isTrue);

      final hyphenatedResult = await useCase('Anne-Marie');

      expect(hyphenatedResult.isRight, isTrue);
      expect(hyphenatedResult.right, isTrue);
    });

    test('should return false when name is longer than 50 characters',
        () async {
      final result = await useCase('A' * 51);

      expect(result.isRight, isTrue);
      expect(result.right, isFalse);
    });

    test('should return false when name contains invalid characters', () async {
      final result = await useCase('John123!');

      expect(result.isRight, isTrue);
      expect(result.right, isFalse);
    });

    test('should return false when name contains only whitespace', () async {
      final result = await useCase('      ');

      expect(result.isRight, isTrue);
      expect(result.right, isFalse);
    });
  });
}
