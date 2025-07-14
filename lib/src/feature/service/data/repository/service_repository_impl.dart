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
    this._allLocaleBusinessServiceMapper,
  );

  final AppLocale _appLocale;
  final BuildConfig _buildConfig;
  final FbFirestoreController _firestoreController;
  final BusinessServiceMapper _businessServiceMapper;
  final AllLocaleBusinessServiceMapper _allLocaleBusinessServiceMapper;

  @override
  Future<AllLocaleBusinessServiceEntity> getBusinessService() async {
    try {
      final dataMap = await _firestoreController.getDocumentFromCollection(
        'business_service',
        _buildConfig.buildEnvironment.name,
      );

      if (dataMap == null) {
        throw const FormatException();
      }

      final businessServiceModelMap = Map<String, dynamic>.from(dataMap as Map);
      final model =
          AllLocaleBusinessServiceModel.fromJson(businessServiceModelMap);
      return _allLocaleBusinessServiceMapper.to(model);
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

  @override
  Future<void> updateAllLocaleBusinessService(
    AllLocaleBusinessServiceEntity allLocaleBusinessServiceEntity,
  ) {
    try {
      return _firestoreController.updateDocumentFromCollection(
        'business_service',
        _buildConfig.buildEnvironment.name,
        _allLocaleBusinessServiceMapper
            .from(allLocaleBusinessServiceEntity)
            .toJson(),
      );
    } catch (e, st) {
      if (e is FirestoreException) {
        throw ServerServiceException(e.cause, st);
      }

      throw UnknownServiceException(e, st);
    }
  }

  @override
  Future<BusinessServiceEntity> getBusinessServiceForLocale() async {
    try {
      final dataMap = await _firestoreController.getDocumentFromCollection(
        'business_service',
        _buildConfig.buildEnvironment.name,
      );

      if (dataMap == null) {
        throw const FormatException();
      }

      final businessServiceModelMap = Map<String, dynamic>.from(
        dataMap[_appLocale.languageCode] as Map,
      );
      final model = BusinessServiceModel.fromJson(businessServiceModelMap);
      return _businessServiceMapper.to(model);
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
