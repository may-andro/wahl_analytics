import 'package:wahl_analytics/l10n/l10n.dart';

enum FormFieldValidationMessage {
  invalidCode,
  noCodeFound,
  emptyCode,
  codeExpired,
  unknown,
  none;

  String? getMessage(AppLocalizations localizations) {
    switch (this) {
      case FormFieldValidationMessage.invalidCode:
        return localizations.verificationCodeFormFieldInvalidValidation;
      case FormFieldValidationMessage.noCodeFound:
        return localizations.verificationCodeFormFieldNotFoundValidation;
      case FormFieldValidationMessage.emptyCode:
        return localizations.verificationCodeFormFieldEmptyValidation;
      case FormFieldValidationMessage.codeExpired:
        return localizations.verificationCodeExpired;
      case FormFieldValidationMessage.unknown:
        return localizations.verificationCodeUnknownFailure;
      case FormFieldValidationMessage.none:
        return null;
    }
  }
}
