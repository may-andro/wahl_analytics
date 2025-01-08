import 'package:wahl_analytics/src/feature/client/domain/entity/entity.dart';

abstract class ClientRepository {
  Future<BusinessClientEntity> getBusinessClient();
}
