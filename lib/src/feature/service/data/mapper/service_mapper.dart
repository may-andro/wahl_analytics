import 'package:core/core.dart';
import 'package:wahl_analytics/src/feature/service/data/model/model.dart';
import 'package:wahl_analytics/src/feature/service/domain/domain.dart';

class ServiceMapper implements Mapper<ServiceModel, ServiceEntity> {
  @override
  ServiceEntity map(ServiceModel from) {
    return ServiceEntity(
      icon: from.icon,
      title: from.title,
      shortDescription: from.shortDescription,
      longDescription: from.longDescription,
    );
  }
}
