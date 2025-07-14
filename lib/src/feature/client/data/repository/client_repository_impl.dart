import 'package:core/core.dart';
import 'package:firebase/firebase.dart';
import 'package:wahl_analytics/src/feature/client/data/mapper/mapper.dart';
import 'package:wahl_analytics/src/feature/client/data/model/model.dart';
import 'package:wahl_analytics/src/feature/client/domain/domain.dart';

class ClientRepositoryImpl implements ClientRepository {
  ClientRepositoryImpl(
    this._appLocale,
    this._buildConfig,
    this._firestoreController,
    this._businessClientMapper,
  );

  final AppLocale _appLocale;
  final BuildConfig _buildConfig;
  final FbFirestoreController _firestoreController;
  final BusinessClientMapper _businessClientMapper;

  @override
  Future<BusinessClientEntity> getBusinessClient() async {
    try {
      final dataMap = await _firestoreController.getDocumentFromCollection(
        'business_client',
        _buildConfig.buildEnvironment.name,
      );

      if (dataMap == null) {
        throw const FormatException();
      }

      final businessClientModelMap = Map<String, dynamic>.from(
        dataMap[_appLocale.languageCode] as Map,
      );
      final model = BusinessClientModel.fromJson(businessClientModelMap);
      return _businessClientMapper.map(model);
    } catch (e, st) {
      if (e is FirestoreException) {
        throw ServerClientException(e.cause, st);
      }

      if (e is TypeError) {
        throw IncorrectJsonClientException(e, st);
      }

      if (e is FormatException) {
        throw NullDataFoundClientException(e, st);
      }

      throw UnknownClientException(e, st);
    }
  }
}
