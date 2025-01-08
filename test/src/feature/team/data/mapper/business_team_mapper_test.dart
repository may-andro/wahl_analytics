import 'package:flutter_test/flutter_test.dart';
import 'package:wahl_analytics/src/feature/service/service.dart';
import 'package:wahl_analytics/src/feature/team/data/data.dart';
import 'package:wahl_analytics/src/feature/team/domain/domain.dart';

void main() {
  group('BusinessTeamMapper', () {
    late BusinessTeamMapper mapper;

    setUp(() {
      mapper = BusinessTeamMapper(TeamMemberMapper(ServiceMapper()));
    });

    test('should correctly maps BusinessTeamModel to BusinessTeamEntity', () {
      const businessTeamEntity = BusinessTeamEntity(
        title: 'url',
        name: 'name',
        description: 'description',
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

      const businessTeamModel = BusinessTeamModel(
        title: 'url',
        name: 'name',
        description: 'description',
        action: 'action',
        members: [
          TeamMemberModel(
            url: 'url',
            name: 'name',
            shortDescription: 'shortDescription',
            longDescription: 'longDescription',
            role: 'role',
            services: [
              ServiceModel(
                icon: 'icon',
                shortDescription: 'shortDescription',
                longDescription: 'longDescription',
                title: 'title',
              ),
            ],
          ),
        ],
      );

      final result = mapper.map(businessTeamModel);

      expect(result, businessTeamEntity);
    });
  });
}
