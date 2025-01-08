import 'package:core/core.dart';
import 'package:wahl_analytics/src/feature/summary/data/model/model.dart';
import 'package:wahl_analytics/src/feature/summary/domain/domain.dart';

class BusinessSummaryMapper
    implements Mapper<BusinessSummaryModel, BusinessSummaryEntity> {
  @override
  BusinessSummaryEntity map(BusinessSummaryModel from) {
    return BusinessSummaryEntity(
      title: from.title,
      descriptions: from.descriptions,
      urls: from.urls,
    );
  }
}
