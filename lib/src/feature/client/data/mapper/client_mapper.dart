import 'package:core/core.dart';
import 'package:wahl_analytics/src/feature/client/data/model/model.dart';
import 'package:wahl_analytics/src/feature/client/domain/domain.dart';
import 'package:wahl_analytics/src/feature/service/service.dart';

class ClientMapper implements Mapper<ClientModel, ClientEntity> {
  ClientMapper(this._serviceMapper);

  final ServiceMapper _serviceMapper;

  @override
  ClientEntity map(ClientModel from) {
    return ClientEntity(
      url: from.url,
      name: from.name,
      shortDescription: from.shortDescription,
      longDescription: from.longDescription,
      services: from.services.map(_serviceMapper.to).toList(),
    );
  }
}
