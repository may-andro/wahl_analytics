import 'package:flutter_test/flutter_test.dart';
import 'package:wahl_analytics/src/feature/client/client.dart';
import 'package:wahl_analytics/src/feature/client/data/data.dart';
import 'package:wahl_analytics/src/feature/service/service.dart';

void main() {
  group('ClientMapper', () {
    late ClientMapper mapper;

    setUp(() {
      mapper = ClientMapper(ServiceMapper());
    });

    test('should correctly maps ClientModel to ClientEntity', () {
      const clientEntity = ClientEntity(
        url: 'url',
        name: 'name',
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

      const clientModel = ClientModel(
        url: 'url',
        name: 'name',
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

      final result = mapper.map(clientModel);

      expect(result, clientEntity);
    });
  });
}
