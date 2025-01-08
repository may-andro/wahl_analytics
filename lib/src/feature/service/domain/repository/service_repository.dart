import 'package:wahl_analytics/src/feature/service/domain/entity/entity.dart';

abstract class ServiceRepository {
  Future<BusinessServiceEntity> getBusinessService();
}
