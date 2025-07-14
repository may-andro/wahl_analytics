import 'package:flutter_test/flutter_test.dart';
import 'package:wahl_analytics/src/feature/validation/domain/use_case/is_valid_long_description_use_case.dart';

void main() {
  group(IsValidLongDescriptionUseCase, () {
    late IsValidLongDescriptionUseCase useCase;

    setUp(() {
      useCase = IsValidLongDescriptionUseCase();
    });

    test(
      'should return $NullLongDescriptionFailure when input is null',
      () async {
        final result = await useCase(null);

        expect(result.isLeft, isTrue);
        expect(result.left, isA<NullLongDescriptionFailure>());
      },
    );

    test(
      'should return $EmptyLongDescriptionFailure when input is empty',
      () async {
        final result = await useCase('');

        expect(result.isLeft, isTrue);
        expect(result.left, isA<EmptyLongDescriptionFailure>());
      },
    );

    test(
      'should return true when message is within allowed characters',
      () async {
        final result = await useCase('A' * 101);

        expect(result.isRight, isTrue);
        expect(result.right, isTrue);
      },
    );

    test(
      'should return false when message is less than 100 characters',
      () async {
        final result = await useCase('A' * 39);

        expect(result.isRight, isTrue);
        expect(result.right, isFalse);
      },
    );

    test(
      'should return false when message is more than 500 characters',
      () async {
        final result = await useCase('A' * 501);

        expect(result.isRight, isTrue);
        expect(result.right, isFalse);
      },
    );

    test('should return false when message contains only whitespace', () async {
      final result = await useCase('       ');

      expect(result.isRight, isTrue);
      expect(result.right, isFalse);
    });
  });
}
