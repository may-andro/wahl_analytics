import 'package:wahl_analytics/src/feature/summary/domain/entity/entity.dart';

abstract class SummaryRepository {
  Future<BusinessSummaryEntity> getBusinessSummary();
}
