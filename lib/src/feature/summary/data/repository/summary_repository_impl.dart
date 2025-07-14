import 'package:core/core.dart';
import 'package:firebase/firebase.dart';
import 'package:wahl_analytics/src/feature/summary/data/mapper/mapper.dart';
import 'package:wahl_analytics/src/feature/summary/data/model/model.dart';
import 'package:wahl_analytics/src/feature/summary/domain/domain.dart';

class SummaryRepositoryImpl implements SummaryRepository {
  SummaryRepositoryImpl(
    this._appLocale,
    this._buildConfig,
    this._firestoreController,
    this._businessSummaryMapper,
  );

  final AppLocale _appLocale;
  final BuildConfig _buildConfig;
  final FbFirestoreController _firestoreController;
  final BusinessSummaryMapper _businessSummaryMapper;

  @override
  Future<BusinessSummaryEntity> getBusinessSummary() async {
    try {
      final dataMap = await _firestoreController.getDocumentFromCollection(
        'business_info',
        _buildConfig.buildEnvironment.name,
      );

      if (dataMap == null) {
        throw const FormatException();
      }

      final businessSummaryModelMap = Map<String, dynamic>.from(
        dataMap[_appLocale.languageCode] as Map,
      );
      final model = BusinessSummaryModel.fromJson(businessSummaryModelMap);
      return _businessSummaryMapper.map(model);
    } catch (e, st) {
      if (e is FirestoreException) {
        throw ServerSummaryException(e.cause, st);
      }

      if (e is TypeError) {
        throw IncorrectJsonSummaryException(e, st);
      }

      if (e is FormatException) {
        throw NullDataFoundSummaryException(e, st);
      }

      throw UnknownSummaryException(e, st);
    }
  }
}
