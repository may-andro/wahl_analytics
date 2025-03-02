import 'package:flutter_test/flutter_test.dart';
import 'package:wahl_analytics/src/feature/validation/domain/use_case/is_valid_verification_code_use_case.dart';

void main() {
  group(IsValidVerificationCodeUseCase, () {
    late IsValidVerificationCodeUseCase useCase;

    setUp(() {
      useCase = IsValidVerificationCodeUseCase();
    });

    test('should return $NullVerificationCodeFailure when input is null',
        () async {
      final result = await useCase(null);

      expect(result.isLeft, isTrue);
      expect(result.left, isA<NullVerificationCodeFailure>());
    });

    test('should return $EmptyVerificationCodeFailure when input is empty',
        () async {
      final result = await useCase('');

      expect(result.isLeft, isTrue);
      expect(result.left, isA<EmptyVerificationCodeFailure>());
    });

    test('should return true when code is valid', () async {
      final result = await useCase('123456');

      expect(result.isRight, isTrue);
      expect(result.right, isTrue);
    });

    test('should return false when code is invalid', () async {
      final result = await useCase('123');

      expect(result.isRight, isTrue);
      expect(result.right, isFalse);
    });
  });
}
