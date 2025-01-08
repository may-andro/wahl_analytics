import 'package:flutter_test/flutter_test.dart';
import 'package:wahl_analytics/src/feature/service/data/data.dart';
import 'package:wahl_analytics/src/feature/service/domain/domain.dart';

void main() {
  group('BusinessServiceMapper', () {
    late BusinessServiceMapper mapper;

    setUp(() {
      mapper = BusinessServiceMapper(ServiceMapper());
    });

    test('should correctly maps BusinessServiceModel to BusinessServiceEntity',
        () {
      const businessServiceEntity = BusinessServiceEntity(
        title: 'url',
        name: 'name',
        description: 'description',
        action: 'action',
        services: [
          ServiceEntity(
            icon: 'icon',
            shortDescription: 'shortDescription',
            longDescription: 'longDescription',
            title: 'title',
          ),
        ],
      );

      const businessServiceModel = BusinessServiceModel(
        title: 'url',
        name: 'name',
        shortDescription: 'description',
        action: 'action',
        services: [
          ServiceModel(
            icon: 'icon',
            shortDescription: 'shortDescription',
            longDescription: 'longDescription',
            title: 'title',
          ),
        ],
      );

      final result = mapper.map(businessServiceModel);

      expect(result, businessServiceEntity);
    });
  });
}
