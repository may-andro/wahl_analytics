import 'package:core/core.dart';
import 'package:wahl_analytics/src/feature/service/data/model/model.dart';
import 'package:wahl_analytics/src/feature/service/domain/domain.dart';

class ServiceMapper implements BiMapper<ServiceModel, ServiceEntity> {
  @override
  ServiceModel from(ServiceEntity from) {
    return ServiceModel(
      icon: from.icon,
      title: from.title,
      shortDescription: from.shortDescription,
      longDescription: from.longDescription,
    );
  }

  @override
  ServiceEntity to(ServiceModel from) {
    return ServiceEntity(
      icon: from.icon,
      title: from.title,
      shortDescription: from.shortDescription,
      longDescription: from.longDescription,
    );
  }
}
