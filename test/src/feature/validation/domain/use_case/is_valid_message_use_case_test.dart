import 'package:flutter_test/flutter_test.dart';
import 'package:wahl_analytics/src/feature/validation/domain/domain.dart';

void main() {
  group('IsValidMessageUseCase', () {
    late IsValidMessageUseCase useCase;

    setUp(() {
      useCase = IsValidMessageUseCase();
    });

    test('should return NullMessageFailure when input is null', () async {
      final result = await useCase(null);

      expect(result.isLeft, isTrue);
      expect(result.left, isA<NullMessageFailure>());
    });

    test('should return EmptyMessageFailure when input is empty', () async {
      final result = await useCase('');

      expect(result.isLeft, isTrue);
      expect(result.left, isA<EmptyMessageFailure>());
    });

    test('should return true when message is within 10 to 500 characters',
        () async {
      final result = await useCase(
        'This is a valid message with enough length.',
      );

      expect(result.isRight, isTrue);
      expect(result.right, isTrue);
    });

    test('should return false when message is less than 10 characters',
        () async {
      final result = await useCase('Too short');

      expect(result.isRight, isTrue);
      expect(result.right, isFalse);
    });

    test('should return false when message is more than 500 characters',
        () async {
      final result = await useCase('A' * 501);

      expect(result.isRight, isTrue);
      expect(result.right, isFalse);
    });

    test('should return false when message contains only whitespace', () async {
      final result = await useCase('       ');

      expect(result.isRight, isTrue);
      expect(result.right, isFalse);
    });
  });
}
