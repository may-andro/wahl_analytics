import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get businessHours =>
      'Monday - Friday: 9:00 AM - 6:00 PM\nSaturday - Sunday: Closed';

  @override
  String get businessHoursLabel => 'Business Hours';

  @override
  String get callUs => 'Call us';

  @override
  String get careerPageFormDescription =>
      'Share your experience and expertise with us. If your skills and background align with our needs, we’ll be in touch as soon as possible to discuss the next steps.';

  @override
  String get careerPageFormTitle => 'Tell Us About Yourself';

  @override
  String get careerPageIntroDescription =>
      'Explore flexible, remote-friendly opportunities and join our mission to make life simpler, more insightful, and more productive. Be part of a team that harnesses the power of data to drive smarter decisions and shape the future of innovation.';

  @override
  String get careerPageIntroLabel => 'Career at Wahl Analytics';

  @override
  String get careerPageIntroTitle => 'Work with us';

  @override
  String get companyName => 'Wahl Analytics';

  @override
  String get contactInfoTitle => 'Get in Touch with Us';

  @override
  String get contactInfoDescription =>
      'We’re here to help you unlock the full potential of data science and analytics. Whether you have questions, need more information, or are ready to start a project, reach out to us, and we’ll respond promptly.';

  @override
  String get contactUs => 'Contact us';

  @override
  String copyright(String year) {
    return '©$year All rights reserved by';
  }

  @override
  String get countryFormFieldEmptyValidation => 'The country seems to be empty';

  @override
  String get countryFormFieldHint => 'Spain';

  @override
  String get countryFormFieldInvalidValidation =>
      'Please provide a valid country';

  @override
  String get countryFormFieldLabel => 'Country';

  @override
  String get countryFormFieldNotFoundValidation => 'No country found';

  @override
  String get devModeTitle => 'Developer Mode';

  @override
  String get devModeSubtitle =>
      'You are one step away from unlocking the developer mode.';

  @override
  String get devModeDescription =>
      'Please add the 6 digit verification code sent to the email.';

  @override
  String get emailFormFieldEmptyValidation => 'The email seems to be empty';

  @override
  String get emailFormFieldHint => 'john@gmail.com';

  @override
  String get emailFormFieldInvalidValidation => 'Please provide a valid email';

  @override
  String get emailFormFieldLabel => 'Email';

  @override
  String get emailFormFieldNotFoundValidation => 'No email found';

  @override
  String get footerLocationLabel => 'Servicing clients worldwide';

  @override
  String get messageFormFieldHint => 'Tell us what excites you';

  @override
  String get messageFormFieldInvalidValidation =>
      'Invalid message, please remove any special characters and less than 500 characters';

  @override
  String get messageFormFieldLabel => 'Message';

  @override
  String get nameFormFieldEmptyValidation => 'The name seems to be empty';

  @override
  String get nameFormFieldHint => 'John Doe';

  @override
  String get nameFormFieldInvalidValidation => 'Please provide a valid name';

  @override
  String get nameFormFieldLabel => 'Name';

  @override
  String get nameFormFieldNotFoundValidation => 'No name found';

  @override
  String get location => 'Location';

  @override
  String get resumeFormFieldButton => 'Add Resume';

  @override
  String get resumeFormFieldFileTooBig => 'Please upload a file within 500kb';

  @override
  String get resumeFormFieldGeneralValidation =>
      'A good resume will make the process faster';

  @override
  String get resumeFormFieldLabel => 'Resume';

  @override
  String get resumeFormFieldUploadFailed =>
      'File could not be uploaded, please upload another file or try later';

  @override
  String get roleFormFieldEmptyValidation => 'The role seems to be empty';

  @override
  String get roleFormFieldHint => 'Senior Business Analyst';

  @override
  String get roleFormFieldInvalidValidation => 'Please provide a valid role';

  @override
  String get roleFormFieldLabel => 'Applying for role';

  @override
  String get roleFormFieldNotFoundValidation => 'No role data found';

  @override
  String get routeNotFoundButton => 'Go to Home';

  @override
  String get routeNotFoundMessage =>
      'Oops! The page you are looking for\\nis not found.';

  @override
  String get routeNotFoundTitle => 'Page Not Found';

  @override
  String get splashProdMessage => 'Warming up the engine...';

  @override
  String get splashStagingWarmupMessage => 'Warming up the app 🔥';

  @override
  String get splashStagingFetchMessage => 'Fetching all dependencies ⬇️';

  @override
  String get splashStagingRegisterMessage => 'Registering the services 🎯';

  @override
  String get splashStagingDoneMessage => 'Setup is finished 🚀';

  @override
  String get splashErrorTitle =>
      'We have encountered an issue during the setup 😵‍💫💻';

  @override
  String get splashErrorMessage =>
      'Please restart the app again or try later. If the issue persists';

  @override
  String get splashContactSupport => 'contact support';

  @override
  String get submitButton => 'Submit';

  @override
  String get userDataConsentCheckboxLabel =>
      'I hereby give my consent to the Wahl Analytics to process my personal data contained in the application documents for the purpose of using my application in future recruitment processes.';

  @override
  String get userDataConsentNotFound =>
      'We need the consent for processing your private data';

  @override
  String get userDataConsentTitle =>
      'Consent to the processing of personal data in future recruitment processes';

  @override
  String get verificationCodeFormFieldEmptyValidation =>
      'The code seems to be empty';

  @override
  String get verificationCodeFormFieldInvalidValidation =>
      'Verification code is invalid';

  @override
  String get verificationCodeFormFieldLabel => 'Verification Code';

  @override
  String get verificationCodeFormFieldNotFoundValidation =>
      'No verification code found';

  @override
  String get verificationCodeExpired =>
      'Validation code has expired, please try later';

  @override
  String get verificationCodeUnknownFailure =>
      'Failed to verify the code at the moment, please try later';
}
