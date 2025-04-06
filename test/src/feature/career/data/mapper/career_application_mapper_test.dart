import 'package:flutter_test/flutter_test.dart';
import 'package:wahl_analytics/src/feature/career/data/mapper/career_application_mapper.dart';
import 'package:wahl_analytics/src/feature/career/domain/entity/career_application_entity.dart';

void main() {
  group(CareerApplicationMapper, () {
    late CareerApplicationMapper mapper;

    setUp(() {
      mapper = CareerApplicationMapper();
    });

    test('should correctly maps CareerApplicationEntity to CareerModel', () {
      final careerApplicationEntity = CareerApplicationEntity.test();

      final careerModel = mapper.map(careerApplicationEntity);

      expect(careerModel.name, equals(careerApplicationEntity.name));
      expect(careerModel.email, equals(careerApplicationEntity.email));
      expect(careerModel.role, equals(careerApplicationEntity.role));
      expect(careerModel.country, equals(careerApplicationEntity.country));
      expect(careerModel.message, equals(careerApplicationEntity.message));
      expect(careerModel.resumeUrl, equals(''));
      expect(careerModel.resumeName, equals(''));
      expect(careerModel.uploadedAt, isNotEmpty);
    });
  });
}
