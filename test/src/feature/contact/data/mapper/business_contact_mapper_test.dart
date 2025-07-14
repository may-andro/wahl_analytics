import 'package:flutter_test/flutter_test.dart';
import 'package:wahl_analytics/src/feature/contact/data/data.dart';

void main() {
  group('BusinessContactMapper', () {
    late BusinessContactMapper mapper;

    setUp(() {
      mapper = BusinessContactMapper();
    });

    test(
      'should correctly maps BusinessContactModel to BusinessContactEntity',
      () {
        const contactUsEntity = BusinessContactModel(
          mobileNumber: 'mobileNumber',
          email: 'email',
          address: ['address'],
        );

        final result = mapper.map(contactUsEntity);

        expect(result.mobileNumber, 'mobileNumber');
        expect(result.email, 'email');
        expect(result.address, ['address']);
      },
    );
  });
}
