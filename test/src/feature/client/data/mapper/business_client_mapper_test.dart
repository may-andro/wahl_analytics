import 'package:flutter_test/flutter_test.dart';
import 'package:wahl_analytics/src/feature/client/client.dart';
import 'package:wahl_analytics/src/feature/client/data/data.dart';
import 'package:wahl_analytics/src/feature/service/service.dart';

void main() {
  group('BusinessClientMapper', () {
    late BusinessClientMapper mapper;

    setUp(() {
      mapper = BusinessClientMapper(ClientMapper(ServiceMapper()));
    });

    test(
      'should correctly maps BusinessClientModel to BusinessClientEntity',
      () {
        const businessClientEntity = BusinessClientEntity(
          title: 'url',
          name: 'name',
          description: 'description',
          action: 'action',
          clients: [
            ClientEntity(
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
            ),
          ],
        );

        const businessClientModel = BusinessClientModel(
          title: 'url',
          name: 'name',
          description: 'description',
          action: 'action',
          clients: [
            ClientModel(
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
            ),
          ],
        );

        final result = mapper.map(businessClientModel);

        expect(result, businessClientEntity);
      },
    );
  });
}
