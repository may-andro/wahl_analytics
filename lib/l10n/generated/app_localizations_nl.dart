import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get addButton => 'Toevoegen';

  @override
  String get addService => 'Service toevoegen';

  @override
  String get businessHours =>
      'Maandag - Vrijdag: 9:00 - 18:00\nZaterdag - Zondag: Gesloten';

  @override
  String get businessHoursLabel => 'Openingstijden';

  @override
  String get callUs => 'Bel ons';

  @override
  String get cancelButton => 'Annuleren';

  @override
  String careersRequestApplication(String count) {
    return '$count aanvragen';
  }

  @override
  String get careerPageFormDescription =>
      'Deel uw ervaring en expertise met ons. Als uw vaardigheden en achtergrond aansluiten bij onze behoeften, nemen we zo snel mogelijk contact met u op om de volgende stappen te bespreken.';

  @override
  String get careerPageFormTitle => 'Vertel ons over jezelf';

  @override
  String get careerPageIntroDescription =>
      'Ontdek flexibele, remote-vriendelijke kansen en sluit je aan bij onze missie om het leven eenvoudiger, inzichtelijker en productiever te maken. Maak deel uit van een team dat de kracht van data benut om slimmere beslissingen te nemen en de toekomst van innovatie vorm te geven.';

  @override
  String get careerPageIntroLabel => 'Carrière bij Wahl Analytics';

  @override
  String get careerPageIntroTitle => 'Werk met ons';

  @override
  String get closeButton => 'Sluiten';

  @override
  String get companyName => 'Wahl Analytics';

  @override
  String get contactInfoTitle => 'Neem contact met ons op';

  @override
  String get contactInfoDescription =>
      'We zijn hier om u te helpen het volledige potentieel van datawetenschap en analyse te benutten. Of u nu vragen heeft, meer informatie nodig heeft of klaar bent om een project te starten, neem contact met ons op en we reageren snel.';

  @override
  String get contactUs => 'Contacteer ons';

  @override
  String copyright(String year) {
    return '©$year Alle rechten voorbehouden door';
  }

  @override
  String get countryFormFieldEmptyValidation =>
      'Het veld land lijkt leeg te zijn';

  @override
  String get countryFormFieldHint => 'Spanje';

  @override
  String get countryFormFieldInvalidValidation => 'Geef een geldig land op';

  @override
  String get countryFormFieldLabel => 'Land';

  @override
  String get countryFormFieldNotFoundValidation => 'Geen land gevonden';

  @override
  String get dataUpdateSuccess => 'Gegevens succesvol bijgewerkt';

  @override
  String get dataUpdateFailure => 'Gegevens bijwerken mislukt';

  @override
  String get deleteButton => 'Verwijderen';

  @override
  String deleteCareerApplicationSuccess(String name) {
    return 'Het carrièreaanvraagverzoek voor $name is succesvol verwijderd';
  }

  @override
  String deleteCareerApplicationFailure(String name) {
    return 'Het is niet gelukt om het carrièreaanvraagverzoek van $name te verwijderen';
  }

  @override
  String get deleteServiceTitle => 'Service verwijderen?';

  @override
  String get deleteServiceSubTitle =>
      'Weet u zeker dat u deze service wilt verwijderen?';

  @override
  String get descriptionFormFieldInvalidValidation =>
      'Geef een geldige beschrijving op';

  @override
  String get descriptionFormFieldLabel => 'Beschrijving';

  @override
  String get descriptionFormFieldNotFoundValidation =>
      'Geen beschrijving gevonden';

  @override
  String get devModeTitle => 'Ontwikkelaarsmodus';

  @override
  String get devModeSubtitle =>
      'U bent één stap verwijderd van het ontgrendelen van de ontwikkelaarsmodus.';

  @override
  String get devModeDescription =>
      'Voer de 6-cijferige verificatiecode in die naar de e-mail is verzonden.';

  @override
  String get emailFormFieldEmptyValidation =>
      'Het e-mailveld lijkt leeg te zijn';

  @override
  String get emailFormFieldHint => 'john@gmail.com';

  @override
  String get emailFormFieldInvalidValidation =>
      'Geef een geldig e-mailadres op';

  @override
  String get emailFormFieldLabel => 'E-mail';

  @override
  String get emailFormFieldNotFoundValidation => 'Geen e-mailadres gevonden';

  @override
  String get errorLoadingFailureMessage =>
      'We konden de gegevens op dit moment niet laden. Probeer de pagina te vernieuwen of kom later terug.';

  @override
  String get footerLocationLabel => 'Klanten wereldwijd bedienen';

  @override
  String get goToHomeButton => 'Ga naar home';

  @override
  String get iconFormFieldHint => 'Selecteer een pictogram';

  @override
  String get iconFormFieldInvalidValidation =>
      'Selecteer een van de beschikbare pictogrammen';

  @override
  String get iconFormFieldLabel => 'Pictogram';

  @override
  String get messageFormFieldHint => 'Vertel ons wat u enthousiast maakt';

  @override
  String get messageFormFieldInvalidValidation =>
      'Ongeldig bericht, verwijder speciale tekens en minder dan 500 tekens';

  @override
  String get messageFormFieldLabel => 'Bericht';

  @override
  String get nameFormFieldEmptyValidation => 'Het naamveld lijkt leeg te zijn';

  @override
  String get nameFormFieldHint => 'John Doe';

  @override
  String get nameFormFieldInvalidValidation => 'Geef een geldige naam op';

  @override
  String get nameFormFieldLabel => 'Naam';

  @override
  String get nameFormFieldNotFoundValidation => 'Geen naam gevonden';

  @override
  String get noCareerRequestFoundTitle => 'Geen inzendingen beschikbaar';

  @override
  String get noCareerRequestFoundDescription =>
      'Er lijken momenteel geen aanvragen te zijn. Kom later terug alstublieft.';

  @override
  String get location => 'Locatie';

  @override
  String get longDescriptionFormFieldInvalidValidation =>
      'Geef een geldige lange beschrijving op';

  @override
  String get longDescriptionFormFieldLabel => 'Lange beschrijving';

  @override
  String get longDescriptionFormFieldNotFoundValidation =>
      'Geen lange beschrijving gevonden';

  @override
  String get resumeFormFieldButton => 'Voeg CV toe';

  @override
  String get resumeFormFieldFileTooBig =>
      'Upload een bestand van maximaal 500kb';

  @override
  String get resumeFormFieldGeneralValidation =>
      'Een goed CV versnelt het proces';

  @override
  String get resumeFormFieldLabel => 'CV';

  @override
  String get resumeFormFieldUploadFailed =>
      'Het bestand kan niet worden geüpload. Probeer een ander bestand of probeer het later opnieuw';

  @override
  String resumeDownloadFailureMessage(String name) {
    return 'Het downloaden van het cv van $name is mislukt';
  }

  @override
  String resumeOpenFailureMessage(String name, Object path) {
    return 'Het openen van het cv op $path is mislukt';
  }

  @override
  String resumeOpenMessage(String path) {
    return 'Cv succesvol gedownload op $path';
  }

  @override
  String get resumeUrlOpenFailureMessage => 'Het openen van het cv is mislukt';

  @override
  String get resumeUrlOpenMessage => 'Het cv-bestand is succesvol geopend';

  @override
  String get roleFormFieldEmptyValidation => 'Het rolveld lijkt leeg te zijn';

  @override
  String get roleFormFieldHint => 'Senior Business Analist';

  @override
  String get roleFormFieldInvalidValidation => 'Geef een geldige rol op';

  @override
  String get roleFormFieldLabel => 'Solliciteren voor rol';

  @override
  String get roleFormFieldNotFoundValidation => 'Geen roldata gevonden';

  @override
  String get routeNotFoundButton => 'Ga naar Home';

  @override
  String get routeNotFoundMessage =>
      'Oeps! De pagina die u zoekt\\nis niet gevonden.';

  @override
  String get routeNotFoundTitle => 'Pagina Niet Gevonden';

  @override
  String serviceUpdatedSuccessMessage(String locale) {
    return 'Diensten zijn succesvol bijgewerkt ✅. Controleer alstublieft of de gegevens correct zijn bijgewerkt in alle talen';
  }

  @override
  String serviceUpdatedFailureMessage(String locale) {
    return 'Het bijwerken van diensten is mislukt voor $locale. Probeer het later opnieuw';
  }

  @override
  String get shortDescriptionFormFieldInvalidValidation =>
      'Geef een geldige korte beschrijving op';

  @override
  String get shortDescriptionFormFieldLabel => 'Korte beschrijving';

  @override
  String get shortDescriptionFormFieldNotFoundValidation =>
      'Geen korte beschrijving gevonden';

  @override
  String get showLess => 'Meer weergeven';

  @override
  String get showMore => 'Minder weergeven';

  @override
  String get splashProdMessage => 'De motor opwarmen...';

  @override
  String get splashStagingWarmupMessage => 'De app opwarmen 🔥';

  @override
  String get splashStagingFetchMessage => 'Alle afhankelijkheden ophalen ⬇️';

  @override
  String get splashStagingRegisterMessage => 'De services registreren 🎯';

  @override
  String get splashStagingDoneMessage => 'De setup is voltooid 🚀';

  @override
  String get splashErrorTitle =>
      'We hebben een probleem ondervonden tijdens de setup 😵‍💫💻';

  @override
  String get splashErrorMessage =>
      'Herstart de app opnieuw of probeer het later. Als het probleem aanhoudt';

  @override
  String get splashContactSupport => 'contacteer support';

  @override
  String get submitButton => 'Indienen';

  @override
  String get titleFormFieldInvalidValidation => 'Geef een geldige titel op';

  @override
  String get titleFormFieldLabel => 'Titel';

  @override
  String get titleFormFieldNotFoundValidation => 'Geen titel gevonden';

  @override
  String get updateService => 'Service bijwerken';

  @override
  String get userDataConsentCheckboxLabel =>
      'Ik geef hierbij mijn toestemming aan Wahl Analytics om mijn persoonlijke gegevens in de sollicitatiedocumenten te verwerken voor toekomstige wervingsprocessen.';

  @override
  String get userDataConsentNotFound =>
      'We hebben uw toestemming nodig voor de verwerking van uw privégegevens';

  @override
  String get userDataConsentTitle =>
      'Toestemming voor verwerking van persoonlijke gegevens in toekomstige wervingsprocessen';

  @override
  String get verificationCodeFormFieldEmptyValidation =>
      'De code lijkt leeg te zijn';

  @override
  String get verificationCodeFormFieldInvalidValidation =>
      'Verificatiecode is ongeldig';

  @override
  String get verificationCodeFormFieldLabel => 'Verificatiecode';

  @override
  String get verificationCodeFormFieldNotFoundValidation =>
      'Geen verificatiecode gevonden';

  @override
  String get verificationCodeExpired =>
      'Verificatiecode is verlopen. Probeer het later opnieuw';

  @override
  String get verificationCodeUnknownFailure =>
      'De code kan momenteel niet worden geverifieerd. Probeer het later opnieuw';
}
