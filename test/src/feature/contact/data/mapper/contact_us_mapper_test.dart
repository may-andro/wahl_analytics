import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wahl_analytics/src/feature/contact/contact.dart';
import 'package:wahl_analytics/src/feature/contact/data/data.dart';

void main() {
  group('ContactUsMapper', () {
    late ContactUsMapper mapper;

    setUp(() {
      mapper = ContactUsMapper();
    });

    test('should correctly maps ContactUsEntity to ContactUsModel', () {
      const contactUsEntity = ContactUsEntity(
        name: 'name',
        email: 'email',
        message: 'message',
      );

      final result = mapper.map(contactUsEntity);

      expect(result.name, 'name');
      expect(result.email, 'email');
      expect(result.message, 'message');
      expect(result.uploadedAt, DateTime.now().toFullDateTime);
    });
  });
}
