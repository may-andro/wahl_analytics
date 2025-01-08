import 'package:flutter_test/flutter_test.dart';
import 'package:wahl_analytics/src/feature/service/service.dart';
import 'package:wahl_analytics/src/feature/team/data/data.dart';
import 'package:wahl_analytics/src/feature/team/domain/domain.dart';

void main() {
  group('TeamMemberMapper', () {
    late TeamMemberMapper mapper;

    setUp(() {
      mapper = TeamMemberMapper(ServiceMapper());
    });

    test('should correctly maps TeamMemberModel to TeamMemberEntity', () {
      const teamMemberEntity = TeamMemberEntity(
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
      );

      const teamMemberModel = TeamMemberModel(
        url: 'url',
        name: 'name',
        role: 'role',
        shortDescription: 'shortDescription',
        longDescription: 'longDescription',
        services: [
          ServiceModel(
            icon: 'icon',
            shortDescription: 'shortDescription',
            longDescription: 'longDescription',
            title: 'title',
          ),
        ],
      );

      expect(mapper.map(teamMemberModel), teamMemberEntity);
    });
  });
}
