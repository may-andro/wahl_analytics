import 'package:flutter_test/flutter_test.dart';
import 'package:wahl_analytics/src/feature/service/data/data.dart';
import 'package:wahl_analytics/src/feature/service/domain/domain.dart';

void main() {
  group('ServiceMapper', () {
    late ServiceMapper mapper;

    setUp(() {
      mapper = ServiceMapper();
    });

    test('should correctly maps ServiceModel to ServiceEntity', () {
      const serviceEntity = ServiceEntity(
        icon: 'icon',
        shortDescription: 'shortDescription',
        longDescription: 'longDescription',
        title: 'title',
      );

      const serviceModel = ServiceModel(
        icon: 'icon',
        shortDescription: 'shortDescription',
        longDescription: 'longDescription',
        title: 'title',
      );

      expect(mapper.map(serviceModel), serviceEntity);
    });
  });
}
