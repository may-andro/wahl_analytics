import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_nl.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('nl'),
  ];

  /// Add button label
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get addButton;

  /// Add service dialog title
  ///
  /// In en, this message translates to:
  /// **'Add service'**
  String get addService;

  /// Business hours timings
  ///
  /// In en, this message translates to:
  /// **'Monday - Friday: 9:00 AM - 6:00 PM\nSaturday - Sunday: Closed'**
  String get businessHours;

  /// Business Hours
  ///
  /// In en, this message translates to:
  /// **'Business Hours'**
  String get businessHoursLabel;

  /// Call us
  ///
  /// In en, this message translates to:
  /// **'Call us'**
  String get callUs;

  /// Cancel button label
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButton;

  /// Counts of applications
  ///
  /// In en, this message translates to:
  /// **'{count} applications'**
  String careersRequestApplication(String count);

  /// Form description text on career page form
  ///
  /// In en, this message translates to:
  /// **'Share your experience and expertise with us. If your skills and background align with our needs, we’ll be in touch as soon as possible to discuss the next steps.'**
  String get careerPageFormDescription;

  /// Form title text on career page form
  ///
  /// In en, this message translates to:
  /// **'Tell Us About Yourself'**
  String get careerPageFormTitle;

  /// Description intro text on career page
  ///
  /// In en, this message translates to:
  /// **'Explore flexible, remote-friendly opportunities and join our mission to make life simpler, more insightful, and more productive. Be part of a team that harnesses the power of data to drive smarter decisions and shape the future of innovation.'**
  String get careerPageIntroDescription;

  /// Small intro label on career page
  ///
  /// In en, this message translates to:
  /// **'Career at Wahl Analytics'**
  String get careerPageIntroLabel;

  /// Title intro text on career page
  ///
  /// In en, this message translates to:
  /// **'Work with us'**
  String get careerPageIntroTitle;

  /// Close button label
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get closeButton;

  /// Company name
  ///
  /// In en, this message translates to:
  /// **'Wahl Analytics'**
  String get companyName;

  /// Contact page intro title text
  ///
  /// In en, this message translates to:
  /// **'Get in Touch with Us'**
  String get contactInfoTitle;

  /// Contact page intro description text
  ///
  /// In en, this message translates to:
  /// **'We’re here to help you unlock the full potential of data science and analytics. Whether you have questions, need more information, or are ready to start a project, reach out to us, and we’ll respond promptly.'**
  String get contactInfoDescription;

  /// Contact us
  ///
  /// In en, this message translates to:
  /// **'Contact us'**
  String get contactUs;

  /// Copyright text
  ///
  /// In en, this message translates to:
  /// **'©{year} All rights reserved by'**
  String copyright(String year);

  /// Form field validation error message when country is empty
  ///
  /// In en, this message translates to:
  /// **'The country seems to be empty'**
  String get countryFormFieldEmptyValidation;

  /// Country form field hint
  ///
  /// In en, this message translates to:
  /// **'Spain'**
  String get countryFormFieldHint;

  /// Form field validation error when country is invalid
  ///
  /// In en, this message translates to:
  /// **'Please provide a valid country'**
  String get countryFormFieldInvalidValidation;

  /// Country form field label
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get countryFormFieldLabel;

  /// Form field validation error message when no country is found
  ///
  /// In en, this message translates to:
  /// **'No country found'**
  String get countryFormFieldNotFoundValidation;

  /// Data update success dialog title
  ///
  /// In en, this message translates to:
  /// **'Data updated successfully'**
  String get dataUpdateSuccess;

  /// Data update failure dialog title
  ///
  /// In en, this message translates to:
  /// **'Data update failed'**
  String get dataUpdateFailure;

  /// Delete button label
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteButton;

  /// Career application deleted successful message
  ///
  /// In en, this message translates to:
  /// **'Career application request is deleted for {name} successfully'**
  String deleteCareerApplicationSuccess(String name);

  /// Career application delete failure message
  ///
  /// In en, this message translates to:
  /// **'Failed to delete career application request of {name}'**
  String deleteCareerApplicationFailure(String name);

  /// Delete service dialog title
  ///
  /// In en, this message translates to:
  /// **'Delete Service?'**
  String get deleteServiceTitle;

  /// Delete service dialog sub title
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this service?'**
  String get deleteServiceSubTitle;

  /// Form field validation error when description is invalid
  ///
  /// In en, this message translates to:
  /// **'Please provide a valid description'**
  String get descriptionFormFieldInvalidValidation;

  /// Description form field label
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get descriptionFormFieldLabel;

  /// Form field validation error message when no description is found
  ///
  /// In en, this message translates to:
  /// **'No description found'**
  String get descriptionFormFieldNotFoundValidation;

  /// Title for the dev mode authentication screen
  ///
  /// In en, this message translates to:
  /// **'Developer Mode'**
  String get devModeTitle;

  /// Subtitle for the dev mode authentication screen
  ///
  /// In en, this message translates to:
  /// **'You are one step away from unlocking the developer mode.'**
  String get devModeSubtitle;

  /// Description message for the dev mode authentication screen
  ///
  /// In en, this message translates to:
  /// **'Please add the 6 digit verification code sent to the email.'**
  String get devModeDescription;

  /// Form field validation error message when email is empty
  ///
  /// In en, this message translates to:
  /// **'The email seems to be empty'**
  String get emailFormFieldEmptyValidation;

  /// Email form field hint
  ///
  /// In en, this message translates to:
  /// **'john@gmail.com'**
  String get emailFormFieldHint;

  /// Form field validation error when email is invalid
  ///
  /// In en, this message translates to:
  /// **'Please provide a valid email'**
  String get emailFormFieldInvalidValidation;

  /// Email form field label
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailFormFieldLabel;

  /// Form field validation error message when no email is found
  ///
  /// In en, this message translates to:
  /// **'No email found'**
  String get emailFormFieldNotFoundValidation;

  /// Generic error message for content loading failure
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t load the data at the moment. Please try refreshing the page or check back later.'**
  String get errorLoadingFailureMessage;

  /// The general location label above address in the home footer
  ///
  /// In en, this message translates to:
  /// **'Servicing clients worldwide'**
  String get footerLocationLabel;

  /// Go to home button
  ///
  /// In en, this message translates to:
  /// **'Go to Home'**
  String get goToHomeButton;

  /// Icon selection form field hint
  ///
  /// In en, this message translates to:
  /// **'Select icon'**
  String get iconFormFieldHint;

  /// Form field validation error when icon is unselected
  ///
  /// In en, this message translates to:
  /// **'Select one of the available icon'**
  String get iconFormFieldInvalidValidation;

  /// Icon selection form field label
  ///
  /// In en, this message translates to:
  /// **'Icon'**
  String get iconFormFieldLabel;

  /// Career message form field hint
  ///
  /// In en, this message translates to:
  /// **'Tell us what excites you'**
  String get messageFormFieldHint;

  /// Form field validation error when message is invalid
  ///
  /// In en, this message translates to:
  /// **'Invalid message, please remove any special characters and less than 500 characters'**
  String get messageFormFieldInvalidValidation;

  /// Career message form field label
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get messageFormFieldLabel;

  /// Form field validation error message when name is empty
  ///
  /// In en, this message translates to:
  /// **'The name seems to be empty'**
  String get nameFormFieldEmptyValidation;

  /// Name form field hint
  ///
  /// In en, this message translates to:
  /// **'John Doe'**
  String get nameFormFieldHint;

  /// Form field validation error when name is invalid
  ///
  /// In en, this message translates to:
  /// **'Please provide a valid name'**
  String get nameFormFieldInvalidValidation;

  /// Name form field label
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get nameFormFieldLabel;

  /// Form field validation error message when no name is found
  ///
  /// In en, this message translates to:
  /// **'No name found'**
  String get nameFormFieldNotFoundValidation;

  /// No application found title
  ///
  /// In en, this message translates to:
  /// **'No Submissions Available'**
  String get noCareerRequestFoundTitle;

  /// No application found description
  ///
  /// In en, this message translates to:
  /// **'It seems there are no applications at the moment. Please check back later'**
  String get noCareerRequestFoundDescription;

  /// location
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// Form field validation error when long description is invalid
  ///
  /// In en, this message translates to:
  /// **'Please provide a valid long description'**
  String get longDescriptionFormFieldInvalidValidation;

  /// Long description form field label
  ///
  /// In en, this message translates to:
  /// **'Long description'**
  String get longDescriptionFormFieldLabel;

  /// Form field validation error message when no long description is found
  ///
  /// In en, this message translates to:
  /// **'No long description found'**
  String get longDescriptionFormFieldNotFoundValidation;

  /// Resume form field button text
  ///
  /// In en, this message translates to:
  /// **'Add Resume'**
  String get resumeFormFieldButton;

  /// Form field validation error when file upload is failed due to large size
  ///
  /// In en, this message translates to:
  /// **'Please upload a file within 500kb'**
  String get resumeFormFieldFileTooBig;

  /// No description provided for @resumeFormFieldGeneralValidation.
  ///
  /// In en, this message translates to:
  /// **'A good resume will make the process faster'**
  String get resumeFormFieldGeneralValidation;

  /// Resume form field button label
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get resumeFormFieldLabel;

  /// Form field validation error when file upload is failed
  ///
  /// In en, this message translates to:
  /// **'File could not be uploaded, please upload another file or try later'**
  String get resumeFormFieldUploadFailed;

  /// Resume file download failure
  ///
  /// In en, this message translates to:
  /// **'Failed to download resume of {name}'**
  String resumeDownloadFailureMessage(String name);

  /// Resume file open failure
  ///
  /// In en, this message translates to:
  /// **'Failed to open resume at {path}'**
  String resumeOpenFailureMessage(String name, Object path);

  /// Resume file opening message
  ///
  /// In en, this message translates to:
  /// **'Resume downloaded at {path} successfully'**
  String resumeOpenMessage(String path);

  /// Resume url opening failure message
  ///
  /// In en, this message translates to:
  /// **'Failed to open the resume'**
  String get resumeUrlOpenFailureMessage;

  /// Resume url opening message
  ///
  /// In en, this message translates to:
  /// **'Resume file opened successfully'**
  String get resumeUrlOpenMessage;

  /// Form field validation error message when role is empty
  ///
  /// In en, this message translates to:
  /// **'The role seems to be empty'**
  String get roleFormFieldEmptyValidation;

  /// Job position form field hint
  ///
  /// In en, this message translates to:
  /// **'Senior Business Analyst'**
  String get roleFormFieldHint;

  /// Form field validation error when role is invalid
  ///
  /// In en, this message translates to:
  /// **'Please provide a valid role'**
  String get roleFormFieldInvalidValidation;

  /// Job position form field label
  ///
  /// In en, this message translates to:
  /// **'Applying for role'**
  String get roleFormFieldLabel;

  /// Form field validation error message when no role is found
  ///
  /// In en, this message translates to:
  /// **'No role data found'**
  String get roleFormFieldNotFoundValidation;

  /// Button label for route not found screen
  ///
  /// In en, this message translates to:
  /// **'Go to Home'**
  String get routeNotFoundButton;

  /// Error message for route not found screen
  ///
  /// In en, this message translates to:
  /// **'Oops! The page you are looking for\\nis not found.'**
  String get routeNotFoundMessage;

  /// Title error for route not found screen
  ///
  /// In en, this message translates to:
  /// **'Page Not Found'**
  String get routeNotFoundTitle;

  /// Service update success message
  ///
  /// In en, this message translates to:
  /// **'Services have been updated successfully ✅. Please verify that the data is updated correctly in all languages'**
  String serviceUpdatedSuccessMessage(String locale);

  /// Service update failure message
  ///
  /// In en, this message translates to:
  /// **'Services updated failed for {locale}. Please try again later'**
  String serviceUpdatedFailureMessage(String locale);

  /// Form field validation error when short description is invalid
  ///
  /// In en, this message translates to:
  /// **'Please provide a valid short description'**
  String get shortDescriptionFormFieldInvalidValidation;

  /// Short description form field label
  ///
  /// In en, this message translates to:
  /// **'Short description'**
  String get shortDescriptionFormFieldLabel;

  /// Form field validation error message when no short description is found
  ///
  /// In en, this message translates to:
  /// **'No short description found'**
  String get shortDescriptionFormFieldNotFoundValidation;

  /// Show less label text
  ///
  /// In en, this message translates to:
  /// **'Show more'**
  String get showLess;

  /// Show more label text
  ///
  /// In en, this message translates to:
  /// **'Show less'**
  String get showMore;

  /// Splash message for loading status
  ///
  /// In en, this message translates to:
  /// **'Warming up the engine...'**
  String get splashProdMessage;

  /// Splash message when DI has started
  ///
  /// In en, this message translates to:
  /// **'Warming up the app 🔥'**
  String get splashStagingWarmupMessage;

  /// Splash message when DI is registering
  ///
  /// In en, this message translates to:
  /// **'Fetching all dependencies ⬇️'**
  String get splashStagingFetchMessage;

  /// Splash message post DI registering
  ///
  /// In en, this message translates to:
  /// **'Registering the services 🎯'**
  String get splashStagingRegisterMessage;

  /// Splash message when the DI is done
  ///
  /// In en, this message translates to:
  /// **'Setup is finished 🚀'**
  String get splashStagingDoneMessage;

  /// Splash error title
  ///
  /// In en, this message translates to:
  /// **'We have encountered an issue during the setup 😵‍💫💻'**
  String get splashErrorTitle;

  /// Splash error title
  ///
  /// In en, this message translates to:
  /// **'Please restart the app again or try later. If the issue persists'**
  String get splashErrorMessage;

  /// contact support
  ///
  /// In en, this message translates to:
  /// **'contact support'**
  String get splashContactSupport;

  /// submit button text
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submitButton;

  /// Form field validation error when tile is invalid
  ///
  /// In en, this message translates to:
  /// **'Please provide a valid title'**
  String get titleFormFieldInvalidValidation;

  /// Title form field label
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get titleFormFieldLabel;

  /// Form field validation error message when no title is found
  ///
  /// In en, this message translates to:
  /// **'No title found'**
  String get titleFormFieldNotFoundValidation;

  /// Update service dialog title
  ///
  /// In en, this message translates to:
  /// **'Update service'**
  String get updateService;

  /// user data consent checkbox text
  ///
  /// In en, this message translates to:
  /// **'I hereby give my consent to the Wahl Analytics to process my personal data contained in the application documents for the purpose of using my application in future recruitment processes.'**
  String get userDataConsentCheckboxLabel;

  /// No consent found for data processing
  ///
  /// In en, this message translates to:
  /// **'We need the consent for processing your private data'**
  String get userDataConsentNotFound;

  /// user data consent text
  ///
  /// In en, this message translates to:
  /// **'Consent to the processing of personal data in future recruitment processes'**
  String get userDataConsentTitle;

  /// Form field validation error message when verification code is empty
  ///
  /// In en, this message translates to:
  /// **'The code seems to be empty'**
  String get verificationCodeFormFieldEmptyValidation;

  /// Form field validation error when verification code is invalid
  ///
  /// In en, this message translates to:
  /// **'Verification code is invalid'**
  String get verificationCodeFormFieldInvalidValidation;

  /// Verification code form field label
  ///
  /// In en, this message translates to:
  /// **'Verification Code'**
  String get verificationCodeFormFieldLabel;

  /// Form field validation error message when no verification is found
  ///
  /// In en, this message translates to:
  /// **'No verification code found'**
  String get verificationCodeFormFieldNotFoundValidation;

  /// Validation code expired message
  ///
  /// In en, this message translates to:
  /// **'Validation code has expired, please try later'**
  String get verificationCodeExpired;

  /// Validation code unknown failure message
  ///
  /// In en, this message translates to:
  /// **'Failed to verify the code at the moment, please try later'**
  String get verificationCodeUnknownFailure;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'nl'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'nl':
      return AppLocalizationsNl();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
