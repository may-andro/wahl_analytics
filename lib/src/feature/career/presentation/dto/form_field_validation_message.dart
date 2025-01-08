import 'package:wahl_analytics/l10n/l10n.dart';

enum FormFieldValidationMessage {
  invalidName,
  noNameFound,
  emptyName,
  invalidEmail,
  noEmailFound,
  emptyEmail,
  invalidRole,
  noRoleFound,
  emptyRole,
  invalidCountry,
  noCountryFound,
  emptyCountry,
  invalidMessage,
  missingConsent,
  fileUploadFailed,
  fileTooBig,
  uploadFile;

  String getMessage(AppLocalizations localizations) {
    switch (this) {
      case FormFieldValidationMessage.invalidName:
        return localizations.nameFormFieldInvalidValidation;
      case FormFieldValidationMessage.noNameFound:
        return localizations.nameFormFieldNotFoundValidation;
      case FormFieldValidationMessage.emptyName:
        return localizations.nameFormFieldEmptyValidation;
      case FormFieldValidationMessage.invalidEmail:
        return localizations.emailFormFieldInvalidValidation;
      case FormFieldValidationMessage.noEmailFound:
        return localizations.emailFormFieldNotFoundValidation;
      case FormFieldValidationMessage.emptyEmail:
        return localizations.emailFormFieldEmptyValidation;
      case FormFieldValidationMessage.invalidRole:
        return localizations.roleFormFieldInvalidValidation;
      case FormFieldValidationMessage.noRoleFound:
        return localizations.roleFormFieldNotFoundValidation;
      case FormFieldValidationMessage.emptyRole:
        return localizations.roleFormFieldEmptyValidation;
      case FormFieldValidationMessage.invalidCountry:
        return localizations.countryFormFieldInvalidValidation;
      case FormFieldValidationMessage.noCountryFound:
        return localizations.countryFormFieldNotFoundValidation;
      case FormFieldValidationMessage.emptyCountry:
        return localizations.countryFormFieldEmptyValidation;
      case FormFieldValidationMessage.invalidMessage:
        return localizations.messageFormFieldInvalidValidation;
      case FormFieldValidationMessage.missingConsent:
        return localizations.userDataConsentNotFound;
      case FormFieldValidationMessage.fileUploadFailed:
        return localizations.resumeFormFieldUploadFailed;
      case FormFieldValidationMessage.fileTooBig:
        return localizations.resumeFormFieldFileTooBig;
      case FormFieldValidationMessage.uploadFile:
        return localizations.resumeFormFieldGeneralValidation;
    }
  }
}
