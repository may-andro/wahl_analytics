import 'package:flutter_test/flutter_test.dart';
import 'package:wahl_analytics/src/feature/contact/domain/domain.dart';

import '../../../../../mock/src/feature/contact/domain/repository/mock_contact_repository.dart';

void main() {
  group('GetBusinessContactUseCase', () {
    late GetBusinessContactUseCase useCase;

    late MockContactRepository mockContactRepository;

    setUp(() {
      mockContactRepository = MockContactRepository();

      useCase = GetBusinessContactUseCase(mockContactRepository);
    });

    test(
      'should return business contact',
      () async {
        const businessContactEntity = BusinessContactEntity(
          email: 'email',
          mobileNumber: 'mobileNumber',
          address: [],
        );
        mockContactRepository.mockGetBusinessContact(businessContactEntity);

        final result = await useCase();

        expect(result.isRight, isTrue);
        expect(result.right, businessContactEntity);
      },
    );

    test(
      'should return BusinessContactFailure '
      'when NullDataFoundContactException is thrown',
      () async {
        mockContactRepository.mockGetBusinessContactThrowsException(
          NullDataFoundContactException(Exception(), StackTrace.current),
        );

        final result = await useCase();

        expect(result.isLeft, isTrue);
        expect(result.left, isA<BusinessContactFailure>());
      },
    );

    test(
      'should return BusinessContactFailure '
      'when ServerContactException thrown',
      () async {
        mockContactRepository.mockGetBusinessContactThrowsException(
          ServerContactException(Exception(), StackTrace.current),
        );

        final result = await useCase();

        expect(result.isLeft, isTrue);
        expect(result.left, isA<BusinessContactFailure>());
      },
    );

    test(
      'should return BusinessContactFailure '
      'when IncorrectJsonContactException thrown',
      () async {
        mockContactRepository.mockGetBusinessContactThrowsException(
          IncorrectJsonContactException(Exception(), StackTrace.current),
        );

        final result = await useCase();

        expect(result.isLeft, isTrue);
        expect(result.left, isA<BusinessContactFailure>());
      },
    );

    test(
      'should return BusinessContactFailure '
      'when UnknownContactException thrown',
      () async {
        mockContactRepository.mockGetBusinessContactThrowsException(
          UnknownContactException(Exception(), StackTrace.current),
        );

        final result = await useCase();

        expect(result.isLeft, isTrue);
        expect(result.left, isA<BusinessContactFailure>());
      },
    );
  });
}
