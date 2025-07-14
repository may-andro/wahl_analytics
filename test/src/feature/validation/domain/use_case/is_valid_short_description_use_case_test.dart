import 'package:flutter_test/flutter_test.dart';
import 'package:wahl_analytics/src/feature/validation/domain/use_case/is_valid_short_description_use_case.dart';

void main() {
  group(InvalidShortDescriptionFailure, () {
    late IsValidShortDescriptionUseCase useCase;

    setUp(() {
      useCase = IsValidShortDescriptionUseCase();
    });

    test(
      'should return $NullShortDescriptionFailure when input is null',
      () async {
        final result = await useCase(null);

        expect(result.isLeft, isTrue);
        expect(result.left, isA<NullShortDescriptionFailure>());
      },
    );

    test(
      'should return $EmptyShortDescriptionFailure when input is empty',
      () async {
        final result = await useCase('');

        expect(result.isLeft, isTrue);
        expect(result.left, isA<EmptyShortDescriptionFailure>());
      },
    );

    test(
      'should return true when message is within allowed characters',
      () async {
        final result = await useCase('A' * 41);

        expect(result.isRight, isTrue);
        expect(result.right, isTrue);
      },
    );

    test(
      'should return false when message is less than 40 characters',
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
