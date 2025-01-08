import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get businessHours =>
      'Lunes - Viernes: 9:00 AM - 6:00 PM\nSábado - Domingo: Cerrado';

  @override
  String get businessHoursLabel => 'Horario comercial';

  @override
  String get callUs => 'Llámanos';

  @override
  String get careerPageFormDescription =>
      'Comparte tu experiencia y conocimientos con nosotros. Si tus habilidades y antecedentes coinciden con nuestras necesidades, nos pondremos en contacto contigo lo antes posible para discutir los próximos pasos.';

  @override
  String get careerPageFormTitle => 'Cuéntanos sobre ti';

  @override
  String get careerPageIntroDescription =>
      'Explora oportunidades flexibles y compatibles con el trabajo remoto y únete a nuestra misión de hacer la vida más simple, perspicaz y productiva. Sé parte de un equipo que aprovecha el poder de los datos para tomar decisiones más inteligentes y dar forma al futuro de la innovación.';

  @override
  String get careerPageIntroLabel => 'Carrera en Wahl Analytics';

  @override
  String get careerPageIntroTitle => 'Trabaja con nosotros';

  @override
  String get companyName => 'Wahl Analytics';

  @override
  String get contactInfoTitle => 'Ponte en contacto con nosotros';

  @override
  String get contactInfoDescription =>
      'Estamos aquí para ayudarte a desbloquear todo el potencial de la ciencia de datos y los análisis. Ya sea que tengas preguntas, necesites más información o estés listo para comenzar un proyecto, contáctanos y responderemos rápidamente.';

  @override
  String get contactUs => 'Contáctanos';

  @override
  String copyright(String year) {
    return '©$year Todos los derechos reservados por';
  }

  @override
  String get countryFormFieldEmptyValidation => 'Parece que el país está vacío';

  @override
  String get countryFormFieldHint => 'España';

  @override
  String get countryFormFieldInvalidValidation =>
      'Por favor, proporciona un país válido';

  @override
  String get countryFormFieldLabel => 'País';

  @override
  String get countryFormFieldNotFoundValidation => 'No se encontró el país';

  @override
  String get devModeTitle => 'Modo desarrollador';

  @override
  String get devModeSubtitle =>
      'Estás a un paso de desbloquear el modo desarrollador.';

  @override
  String get devModeDescription =>
      'Por favor, añade el código de verificación de 6 dígitos enviado al correo electrónico.';

  @override
  String get emailFormFieldEmptyValidation => 'Parece que el correo está vacío';

  @override
  String get emailFormFieldHint => 'juan@gmail.com';

  @override
  String get emailFormFieldInvalidValidation =>
      'Por favor, proporciona un correo electrónico válido';

  @override
  String get emailFormFieldLabel => 'Correo electrónico';

  @override
  String get emailFormFieldNotFoundValidation => 'No se encontró el correo';

  @override
  String get footerLocationLabel => 'Atendiendo clientes en todo el mundo';

  @override
  String get messageFormFieldHint => 'Cuéntanos qué te emociona';

  @override
  String get messageFormFieldInvalidValidation =>
      'Mensaje inválido, por favor elimina cualquier carácter especial y usa menos de 500 caracteres';

  @override
  String get messageFormFieldLabel => 'Mensaje';

  @override
  String get nameFormFieldEmptyValidation => 'Parece que el nombre está vacío';

  @override
  String get nameFormFieldHint => 'Juan Pérez';

  @override
  String get nameFormFieldInvalidValidation =>
      'Por favor, proporciona un nombre válido';

  @override
  String get nameFormFieldLabel => 'Nombre';

  @override
  String get nameFormFieldNotFoundValidation => 'No se encontró el nombre';

  @override
  String get location => 'Ubicación';

  @override
  String get resumeFormFieldButton => 'Añadir currículum';

  @override
  String get resumeFormFieldFileTooBig =>
      'Por favor, sube un archivo de hasta 500kb';

  @override
  String get resumeFormFieldGeneralValidation =>
      'Un buen currículum acelerará el proceso';

  @override
  String get resumeFormFieldLabel => 'Currículum';

  @override
  String get resumeFormFieldUploadFailed =>
      'No se pudo cargar el archivo, sube otro archivo o inténtalo más tarde';

  @override
  String get roleFormFieldEmptyValidation => 'Parece que el rol está vacío';

  @override
  String get roleFormFieldHint => 'Analista de Negocios Senior';

  @override
  String get roleFormFieldInvalidValidation =>
      'Por favor, proporciona un rol válido';

  @override
  String get roleFormFieldLabel => 'Postulando al rol de';

  @override
  String get roleFormFieldNotFoundValidation =>
      'No se encontró información del rol';

  @override
  String get routeNotFoundButton => 'Ir al inicio';

  @override
  String get routeNotFoundMessage =>
      '¡Ups! La página que estás buscando\nno se encuentra.';

  @override
  String get routeNotFoundTitle => 'Página no encontrada';

  @override
  String get splashProdMessage => 'Calentando el motor...';

  @override
  String get splashStagingWarmupMessage => 'Calentando la aplicación 🔥';

  @override
  String get splashStagingFetchMessage =>
      'Obteniendo todas las dependencias ⬇️';

  @override
  String get splashStagingRegisterMessage => 'Registrando los servicios 🎯';

  @override
  String get splashStagingDoneMessage => 'La configuración está lista 🚀';

  @override
  String get splashErrorTitle =>
      'Encontramos un problema durante la configuración 😵‍💫💻';

  @override
  String get splashErrorMessage =>
      'Por favor, reinicia la aplicación o inténtalo más tarde. Si el problema persiste';

  @override
  String get splashContactSupport => 'contacta con soporte';

  @override
  String get submitButton => 'Enviar';

  @override
  String get userDataConsentCheckboxLabel =>
      'Por la presente doy mi consentimiento a Wahl Analytics para procesar mis datos personales contenidos en los documentos de la solicitud con el fin de utilizar mi solicitud en futuros procesos de selección.';

  @override
  String get userDataConsentNotFound =>
      'Necesitamos el consentimiento para procesar tus datos personales';

  @override
  String get userDataConsentTitle =>
      'Consentimiento para el procesamiento de datos personales en futuros procesos de selección';

  @override
  String get verificationCodeFormFieldEmptyValidation =>
      'Parece que el código está vacío';

  @override
  String get verificationCodeFormFieldInvalidValidation =>
      'El código de verificación no es válido';

  @override
  String get verificationCodeFormFieldLabel => 'Código de verificación';

  @override
  String get verificationCodeFormFieldNotFoundValidation =>
      'No se encontró el código de verificación';

  @override
  String get verificationCodeExpired =>
      'El código de validación ha caducado, por favor inténtalo más tarde';

  @override
  String get verificationCodeUnknownFailure =>
      'No se pudo verificar el código en este momento, por favor inténtalo más tarde';
}
