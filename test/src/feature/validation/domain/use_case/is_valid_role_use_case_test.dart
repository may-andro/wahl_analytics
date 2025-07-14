import 'package:flutter_test/flutter_test.dart';
import 'package:wahl_analytics/src/feature/validation/domain/domain.dart';

void main() {
  group('IsValidRoleUseCase', () {
    late IsValidRoleUseCase useCase;

    setUp(() {
      useCase = IsValidRoleUseCase();
    });

    test('should return NullRoleFailure when input is null', () async {
      final result = await useCase(null);

      expect(result.isLeft, isTrue);
      expect(result.left, isA<NullRoleFailure>());
    });

    test('should return EmptyRoleFailure when input is empty', () async {
      final result = await useCase('');

      expect(result.isLeft, isTrue);
      expect(result.left, isA<EmptyRoleFailure>());
    });

    test('should return true when role is alphabetic characters', () async {
      final result = await useCase('Software Engineer');

      expect(result.isRight, isTrue);
      expect(result.right, isTrue);
    });

    test('should return true when role has valid special characters', () async {
      final result = await useCase('Software-Engineer');

      expect(result.isRight, isTrue);
      expect(result.right, isTrue);
    });

    test(
      'should return false when role is longer than 40 characters',
      () async {
        final result = await useCase('A' * 41);

        expect(result.isRight, isTrue);
        expect(result.right, isFalse);
      },
    );

    test('should return false when role contains invalid characters', () async {
      final result = await useCase('Engineer123!');

      expect(result.isRight, isTrue);
      expect(result.right, isFalse);
    });

    test('should return false when role contains only whitespace', () async {
      final result = await useCase('      ');

      expect(result.isRight, isTrue);
      expect(result.right, isFalse);
    });
  });
}
