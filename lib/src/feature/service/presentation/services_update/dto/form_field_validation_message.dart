import 'package:wahl_analytics/l10n/l10n.dart';

enum FormFieldValidationMessage {
  invalidTitle,
  noTitleFound,
  invalidDescription,
  noDescriptionFound,
  invalidShortDescription,
  noShortDescriptionFound,
  invalidLongDescription,
  noLongDescriptionFound;

  String getMessage(AppLocalizations localizations) {
    switch (this) {
      case FormFieldValidationMessage.invalidTitle:
        return localizations.titleFormFieldInvalidValidation;
      case FormFieldValidationMessage.noTitleFound:
        return localizations.titleFormFieldNotFoundValidation;
      case FormFieldValidationMessage.invalidDescription:
        return localizations.descriptionFormFieldInvalidValidation;
      case FormFieldValidationMessage.noDescriptionFound:
        return localizations.descriptionFormFieldNotFoundValidation;
      case FormFieldValidationMessage.invalidShortDescription:
        return localizations.shortDescriptionFormFieldInvalidValidation;
      case FormFieldValidationMessage.noShortDescriptionFound:
        return localizations.shortDescriptionFormFieldNotFoundValidation;
      case FormFieldValidationMessage.invalidLongDescription:
        return localizations.longDescriptionFormFieldInvalidValidation;
      case FormFieldValidationMessage.noLongDescriptionFound:
        return localizations.longDescriptionFormFieldNotFoundValidation;
    }
  }
}
