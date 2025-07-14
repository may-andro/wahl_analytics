import 'package:core/core.dart';
import 'package:firebase/firebase.dart';
import 'package:wahl_analytics/src/feature/contact/data/mapper/mapper.dart';
import 'package:wahl_analytics/src/feature/contact/data/model/model.dart';
import 'package:wahl_analytics/src/feature/contact/domain/domain.dart';

class ContactRepositoryImpl implements ContactRepository {
  ContactRepositoryImpl(
    this._appLocale,
    this._buildConfig,
    this._firestoreController,
    this._businessContactMapper,
    this._contactUsMapper,
  );

  final AppLocale _appLocale;
  final BuildConfig _buildConfig;
  final FbFirestoreController _firestoreController;
  final BusinessContactMapper _businessContactMapper;
  final ContactUsMapper _contactUsMapper;

  @override
  Future<BusinessContactEntity> getBusinessContact() async {
    try {
      final dataMap = await _firestoreController.getDocumentFromCollection(
        'business_contact',
        _buildConfig.buildEnvironment.name,
      );

      if (dataMap == null) {
        throw const FormatException();
      }

      final businessContactModelMap = Map<String, dynamic>.from(
        dataMap[_appLocale.languageCode] as Map,
      );
      final model = BusinessContactModel.fromJson(businessContactModelMap);
      return _businessContactMapper.map(model);
    } catch (e, st) {
      if (e is FirestoreException) {
        throw ServerContactException(e.cause, st);
      }

      if (e is TypeError) {
        throw IncorrectJsonContactException(e, st);
      }

      if (e is FormatException) {
        throw NullDataFoundContactException(e, st);
      }

      throw UnknownContactException(e, st);
    }
  }

  @override
  Future<void> submitApplication(ContactUsEntity contactUsEntity) {
    return _firestoreController.addToCollection(
      'contact_us',
      _contactUsMapper.map(contactUsEntity).toJson(),
    );
  }
}
