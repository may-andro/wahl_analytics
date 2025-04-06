import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wahl_analytics/src/feature/career/data/mapper/mapper.dart';
import 'package:wahl_analytics/src/feature/career/data/model/model.dart';
import 'package:wahl_analytics/src/feature/career/domain/domain.dart';

void main() {
  group(CareerMapper, () {
    late CareerMapper mapper;

    setUp(() {
      mapper = CareerMapper();
    });

    test('should correctly maps CareerEntity to CareerModel', () {
      final careerEntity = CareerEntity.test();

      final careerModel = mapper.from(careerEntity);

      expect(careerModel.name, equals(careerEntity.name));
      expect(careerModel.email, equals(careerEntity.email));
      expect(careerModel.role, equals(careerEntity.role));
      expect(careerModel.country, equals(careerEntity.country));
      expect(careerModel.message, equals(careerEntity.message));
      expect(careerModel.resumeUrl, equals(careerEntity.resumeUrl));
      expect(careerModel.resumeName, equals(careerEntity.resumeName));
      expect(
        careerModel.uploadedAt,
        equals(careerEntity.uploadedAt.toFullDateTime),
      );
    });

    test('should correctly maps CareerModel to CareerEntity', () {
      final careerModel = CareerModel.test();

      final careerEntity = mapper.to(careerModel);

      expect(careerEntity.name, equals(careerModel.name));
      expect(careerEntity.email, equals(careerModel.email));
      expect(careerEntity.role, equals(careerModel.role));
      expect(careerEntity.country, equals(careerModel.country));
      expect(careerEntity.message, equals(careerModel.message));
      expect(careerEntity.resumeUrl, equals(careerModel.resumeUrl));
      expect(careerEntity.resumeName, equals(careerModel.resumeName));
      expect(
        careerEntity.uploadedAt,
        equals(careerModel.uploadedAt.toFullDateTime),
      );
    });
  });
}
