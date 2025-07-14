import 'package:core/core.dart';
import 'package:firebase/firebase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wahl_analytics/src/feature/service/service.dart';
import 'package:wahl_analytics/src/feature/team/data/data.dart';
import 'package:wahl_analytics/src/feature/team/domain/domain.dart';

import '../../../../../mock/firebase/mock_fb_firestore_controller.dart';

void main() {
  group('TeamRepositoryImpl', () {
    late TeamRepositoryImpl repository;

    late AppLocale appLocale;
    late BuildConfig buildConfig;
    late MockFbFirestoreController mockFbFirestoreController;
    late ServiceMapper serviceMapper;
    late BusinessTeamMapper businessTeamMapper;
    late TeamMemberMapper teamMemberMapper;

    final Map<String, dynamic> testTeamData = {
      'en': {
        'name': 'name',
        'title': 'title',
        'shortDescription': 'shortDescription',
        'action': 'action',
        'members': [
          {
            'url': 'url',
            'name': 'name',
            'role': 'role',
            'shortDescription': 'shortDescription',
            'longDescription': 'longDescription',
            'services': [
              {
                'icon': 'icon',
                'title': 'title',
                'shortDescription': 'shortDescription',
                'longDescription': 'longDescription',
              },
            ],
          },
        ],
      },
    };

    const businessTeamEntity = BusinessTeamEntity(
      title: 'title',
      name: 'name',
      description: 'shortDescription',
      action: 'action',
      members: [
        TeamMemberEntity(
          url: 'url',
          name: 'name',
          shortDescription: 'shortDescription',
          longDescription: 'longDescription',
          role: 'role',
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

    setUp(() {
      appLocale = AppLocale('en');
      buildConfig = BuildConfig(buildEnvironment: BuildEnvironment.staging);
      mockFbFirestoreController = MockFbFirestoreController();
      serviceMapper = ServiceMapper();
      teamMemberMapper = TeamMemberMapper(serviceMapper);
      businessTeamMapper = BusinessTeamMapper(teamMemberMapper);

      repository = TeamRepositoryImpl(
        appLocale,
        buildConfig,
        mockFbFirestoreController,
        businessTeamMapper,
      );
    });

    group('getBusinessTeam', () {
      test('should return BusinessTeamEntity '
          'when firebase has valid data', () async {
        mockFbFirestoreController.mockGetDocumentFromCollection(testTeamData);

        final result = await repository.getBusinessTeam();

        expect(result, businessTeamEntity);
      });

      test('should throw NullDataFoundTeamException '
          'when firebase has null data', () {
        mockFbFirestoreController.mockGetDocumentFromCollection(null);

        expect(
          () async => await repository.getBusinessTeam(),
          throwsA(
            predicate((exception) => exception is NullDataFoundTeamException),
          ),
        );
      });

      test('should throw ServerTeamException '
          'when firebase has FirestoreException exception', () {
        final exception = FirestoreException(Exception(), StackTrace.current);
        mockFbFirestoreController.mockGetDocumentFromCollectionThrowsException(
          exception,
        );

        expect(
          () async => await repository.getBusinessTeam(),
          throwsA(predicate((exception) => exception is ServerTeamException)),
        );
      });

      test('should throw IncorrectJsonTeamException '
          'when json is different from expected', () {
        mockFbFirestoreController.mockGetDocumentFromCollection({
          'test': {'name': 'name', 'title': 'title'},
        });

        expect(
          () async => await repository.getBusinessTeam(),
          throwsA(
            predicate((exception) => exception is IncorrectJsonTeamException),
          ),
        );
      });

      test('should throw UnknownTeamException '
          'when json is different from expected', () {
        final exception = Exception();
        mockFbFirestoreController.mockGetDocumentFromCollectionThrowsException(
          exception,
        );

        expect(
          () async => await repository.getBusinessTeam(),
          throwsA(predicate((exception) => exception is UnknownTeamException)),
        );
      });
    });
  });
}
