import 'package:flutter_test/flutter_test.dart';
import 'package:wahl_analytics/src/feature/validation/domain/domain.dart';

void main() {
  group('IsValidCountryUseCase', () {
    late IsValidCountryUseCase useCase;

    setUp(() {
      useCase = IsValidCountryUseCase();
    });

    test('should return NullCountryFailure when input is null', () async {
      final result = await useCase(null);

      expect(result.isLeft, isTrue);
      expect(result.left, isA<NullCountryFailure>());
    });

    test('should return EmptyCountryFailure when input is empty', () async {
      final result = await useCase('');

      expect(result.isLeft, isTrue);
      expect(result.left, isA<EmptyCountryFailure>());
    });

    test('should return true when country name is valid', () async {
      final result = await useCase('United States');

      expect(result.isRight, isTrue);
      expect(result.right, isTrue);
    });

    test('should return true when country name is with hyphens and spaces',
        () async {
      final result = await useCase("Cote d'Ivoire");

      expect(result.isRight, isTrue);
      expect(result.right, isTrue);
    });

    test('should return false when country name has special characters',
        () async {
      final result = await useCase('United@States');

      expect(result.isRight, isTrue);
      expect(result.right, isFalse);
    });

    test('should return false when country name is too short', () async {
      final result = await useCase('U');

      expect(result.isRight, isTrue);
      expect(result.right, isFalse);
    });

    test('should return false when country name is too long', () async {
      final result = await useCase(
        'ThisIsAnExceptionallyLongCountryNameThatExceedsTheLimit',
      );

      expect(result.isRight, isTrue);
      expect(result.right, isFalse);
    });
  });
}
