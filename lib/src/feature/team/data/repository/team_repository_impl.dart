import 'package:core/core.dart';
import 'package:firebase/firebase.dart';
import 'package:wahl_analytics/src/feature/team/data/mapper/mapper.dart';
import 'package:wahl_analytics/src/feature/team/data/model/model.dart';
import 'package:wahl_analytics/src/feature/team/domain/domain.dart';

class TeamRepositoryImpl implements TeamRepository {
  TeamRepositoryImpl(
    this._appLocale,
    this._buildConfig,
    this._firestoreController,
    this._businessTeamMapper,
  );

  final AppLocale _appLocale;
  final BuildConfig _buildConfig;
  final FbFirestoreController _firestoreController;
  final BusinessTeamMapper _businessTeamMapper;

  @override
  Future<BusinessTeamEntity> getBusinessTeam() async {
    try {
      final dataMap = await _firestoreController.getDocumentFromCollection(
        'business_team',
        _buildConfig.buildEnvironment.name,
      );

      if (dataMap == null) {
        throw const FormatException();
      }

      final businessTeamModelMap = Map<String, dynamic>.from(
        dataMap[_appLocale.languageCode] as Map,
      );
      final model = BusinessTeamModel.fromJson(businessTeamModelMap);
      return _businessTeamMapper.map(model);
    } catch (e, st) {
      if (e is FirestoreException) {
        throw ServerTeamException(e.cause, st);
      }

      if (e is TypeError) {
        throw IncorrectJsonTeamException(e, st);
      }

      if (e is FormatException) {
        throw NullDataFoundTeamException(e, st);
      }

      throw UnknownTeamException(e, st);
    }
  }
}
