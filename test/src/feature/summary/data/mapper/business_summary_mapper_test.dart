import 'package:flutter_test/flutter_test.dart';
import 'package:wahl_analytics/src/feature/summary/data/data.dart';
import 'package:wahl_analytics/src/feature/summary/domain/domain.dart';

void main() {
  group('BusinessSummaryMapper', () {
    late BusinessSummaryMapper mapper;

    setUp(() {
      mapper = BusinessSummaryMapper();
    });

    test('should correctly maps BusinessSummaryModel to BusinessSummaryEntity',
        () {
      const businessSummaryEntity = BusinessSummaryEntity(
        title: 'url',
        urls: ['url'],
        descriptions: ['description'],
      );

      const businessSummaryModel = BusinessSummaryModel(
        title: 'url',
        urls: ['url'],
        descriptions: ['description'],
      );

      final result = mapper.map(businessSummaryModel);

      expect(result, businessSummaryEntity);
    });
  });
}
