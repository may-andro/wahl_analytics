import 'package:wahl_analytics/src/feature/service/domain/entity/entity.dart';

abstract class ServiceRepository {
  Future<AllLocaleBusinessServiceEntity> getBusinessService();

  Future<BusinessServiceEntity> getBusinessServiceForLocale();

  Future<void> updateAllLocaleBusinessService(
    AllLocaleBusinessServiceEntity allLocaleBusinessServiceEntity,
  );
}
