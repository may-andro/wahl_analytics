import 'package:wahl_analytics/l10n/l10n.dart';

enum FormFieldValidationMessage {
  invalidName,
  noNameFound,
  emptyName,
  invalidEmail,
  noEmailFound,
  emptyEmail,
  invalidMessage,
  missingConsent;

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
      case FormFieldValidationMessage.invalidMessage:
        return localizations.messageFormFieldInvalidValidation;
      case FormFieldValidationMessage.missingConsent:
        return localizations.userDataConsentNotFound;
    }
  }
}
