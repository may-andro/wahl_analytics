import 'package:core/core.dart';
import 'package:wahl_analytics/src/feature/client/data/mapper/client_mapper.dart';
import 'package:wahl_analytics/src/feature/client/data/model/model.dart';
import 'package:wahl_analytics/src/feature/client/domain/domain.dart';

class BusinessClientMapper
    implements Mapper<BusinessClientModel, BusinessClientEntity> {
  BusinessClientMapper(this._clientMapper);

  final ClientMapper _clientMapper;

  @override
  BusinessClientEntity map(BusinessClientModel from) {
    return BusinessClientEntity(
      name: from.name,
      title: from.title,
      description: from.description,
      action: from.action,
      clients: from.clients.map(_clientMapper.map).toList(),
    );
  }
}
