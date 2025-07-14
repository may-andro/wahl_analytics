import 'package:flutter_test/flutter_test.dart';
import 'package:wahl_analytics/src/feature/service/service.dart';
import 'package:wahl_analytics/src/feature/team/domain/domain.dart';

import '../../../../../mock/src/feature/team/domain/repository/mock_team_repository.dart';

void main() {
  group('GetBusinessTeamUseCase', () {
    late GetBusinessTeamUseCase useCase;

    late MockTeamRepository mockTeamRepository;

    setUp(() {
      mockTeamRepository = MockTeamRepository();

      useCase = GetBusinessTeamUseCase(mockTeamRepository);
    });

    test('should return business team', () async {
      const businessTeamEntity = BusinessTeamEntity(
        title: 'url',
        name: 'name',
        description: 'description',
        action: 'action',
        members: [
          TeamMemberEntity(
            url: 'url',
            name: 'name',
            role: 'role',
            shortDescription: 'shortDescription',
            longDescription: 'longDescription',
            services: [
              ServiceEntity(
                icon: 'icon',
                shortDescription: 'shortDescription',
                longDescription: 'longDescription',
                title: 'title',
              ),
            ],
          ),
        ],
      );
      mockTeamRepository.mockGetBusinessTeam(businessTeamEntity);

      final result = await useCase();

      expect(result.isRight, isTrue);
      expect(result.right, businessTeamEntity);
    });

    test('should return BusinessTeamFailure '
        'when NullDataFoundTeamException is thrown', () async {
      mockTeamRepository.mockGetBusinessTeamThrowsException(
        NullDataFoundTeamException(Exception(), StackTrace.current),
      );

      final result = await useCase();

      expect(result.isLeft, isTrue);
      expect(result.left, isA<BusinessTeamFailure>());
    });

    test('should return BusinessTeamFailure '
        'when ServerTeamException thrown', () async {
      mockTeamRepository.mockGetBusinessTeamThrowsException(
        ServerTeamException(Exception(), StackTrace.current),
      );

      final result = await useCase();

      expect(result.isLeft, isTrue);
      expect(result.left, isA<BusinessTeamFailure>());
    });

    test('should return BusinessTeamFailure '
        'when IncorrectJsonTeamException thrown', () async {
      mockTeamRepository.mockGetBusinessTeamThrowsException(
        IncorrectJsonTeamException(Exception(), StackTrace.current),
      );

      final result = await useCase();

      expect(result.isLeft, isTrue);
      expect(result.left, isA<BusinessTeamFailure>());
    });

    test('should return BusinessTeamFailure '
        'when UnknownTeamException thrown', () async {
      mockTeamRepository.mockGetBusinessTeamThrowsException(
        UnknownTeamException(Exception(), StackTrace.current),
      );

      final result = await useCase();

      expect(result.isLeft, isTrue);
      expect(result.left, isA<BusinessTeamFailure>());
    });
  });
}
