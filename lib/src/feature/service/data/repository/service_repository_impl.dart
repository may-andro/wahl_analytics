import 'package:core/core.dart';
import 'package:firebase/firebase.dart';
import 'package:wahl_analytics/src/feature/service/data/mapper/mapper.dart';
import 'package:wahl_analytics/src/feature/service/data/model/model.dart';
import 'package:wahl_analytics/src/feature/service/domain/domain.dart';

class ServiceRepositoryImpl implements ServiceRepository {
  ServiceRepositoryImpl(
    this._appLocale,
    this._buildConfig,
    this._firestoreController,
    this._businessServiceMapper,
  );

  final AppLocale _appLocale;
  final BuildConfig _buildConfig;
  final FbFirestoreController _firestoreController;
  final BusinessServiceMapper _businessServiceMapper;

  @override
  Future<BusinessServiceEntity> getBusinessService() async {
    try {
      final dataMap = await _firestoreController.getDocumentFromCollection(
        'business_service',
        _buildConfig.buildEnvironment.name,
      );

      if (dataMap == null) {
        throw const FormatException();
      }

      final businessServiceModelMap = Map<String, dynamic>.from(
        dataMap[_appLocale.locale] as Map,
      );
      final model = BusinessServiceModel.fromJson(businessServiceModelMap);
      return _businessServiceMapper.map(model);
    } catch (e, st) {
      if (e is FirestoreException) {
        throw ServerServiceException(e.cause, st);
      }

      if (e is TypeError) {
        throw IncorrectJsonServiceException(e, st);
      }

      if (e is FormatException) {
        throw NullDataFoundServiceException(e, st);
      }

      throw UnknownServiceException(e, st);
    }
  }
}
