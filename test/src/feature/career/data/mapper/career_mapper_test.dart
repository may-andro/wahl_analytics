import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wahl_analytics/src/feature/career/data/mapper/mapper.dart';
import 'package:wahl_analytics/src/feature/career/domain/domain.dart';

void main() {
  group('CareerMapper', () {
    late CareerMapper mapper;

    setUp(() {
      mapper = CareerMapper();
    });

    test('should correctly maps CareerEntity to CareerModel', () {
      // Arrange
      final careerEntity = CareerEntity(
        name: 'John Doe',
        email: 'john.doe@example.com',
        role: 'Software Engineer',
        country: 'USA',
        message: 'Excited to apply for this role.',
        fileData: Uint8List.fromList([0, 1, 2, 3]),
      );

      // Act
      final careerModel = mapper.map(careerEntity);

      // Assert
      expect(careerModel.name, equals(careerEntity.name));
      expect(careerModel.email, equals(careerEntity.email));
      expect(careerModel.role, equals(careerEntity.role));
      expect(careerModel.country, equals(careerEntity.country));
      expect(careerModel.message, equals(careerEntity.message));
      expect(careerModel.resumeUrl, equals(''));
      expect(
        careerModel.uploadedAt,
        allOf(
          isNotNull,
          isA<String>(),
        ), // Ensure `uploadedAt` is a valid non-null string
      );
    });
  });
}
