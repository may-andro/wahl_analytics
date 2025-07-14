import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wahl_analytics/src/feature/contact/domain/domain.dart';

import '../../../../../mock/src/feature/contact/domain/repository/mock_contact_repository.dart';

void main() {
  group('SubmitContactUsApplicationUseCase', () {
    late SubmitContactUsApplicationUseCase useCase;

    late MockContactRepository mockContactRepository;

    const contactUsEntity = ContactUsEntity(
      email: 'email',
      name: 'name',
      message: 'message',
    );

    setUpAll(() {
      registerFallbackValue(contactUsEntity);
    });

    setUp(() {
      mockContactRepository = MockContactRepository();

      useCase = SubmitContactUsApplicationUseCase(mockContactRepository);
    });

    test('should submit application successfully', () async {
      mockContactRepository.mockSubmitApplication();

      final result = await useCase(contactUsEntity);

      expect(result.isRight, isTrue);
      verify(
        () => mockContactRepository.submitApplication(contactUsEntity),
      ).called(1);
    });

    test(
      'should return SubmitContactUsApplicationFailure when exception occurs',
      () async {
        mockContactRepository.mockSubmitApplicationThrowsException(Exception());

        final result = await useCase(contactUsEntity);

        expect(result.isLeft, isTrue);
        expect(result.left, isA<SubmitContactUsApplicationFailure>());
      },
    );
  });
}
