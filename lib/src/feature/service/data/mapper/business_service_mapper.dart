import 'package:core/core.dart';
import 'package:wahl_analytics/src/feature/service/data/mapper/service_mapper.dart';
import 'package:wahl_analytics/src/feature/service/data/model/model.dart';
import 'package:wahl_analytics/src/feature/service/domain/domain.dart';

class BusinessServiceMapper
    implements Mapper<BusinessServiceModel, BusinessServiceEntity> {
  BusinessServiceMapper(this._serviceMapper);

  final ServiceMapper _serviceMapper;

  @override
  BusinessServiceEntity map(BusinessServiceModel from) {
    return BusinessServiceEntity(
      name: from.name,
      title: from.title,
      description: from.shortDescription,
      action: from.action,
      services: from.services.map((service) {
        return _serviceMapper.map(service);
      }).toList(),
    );
  }
}
