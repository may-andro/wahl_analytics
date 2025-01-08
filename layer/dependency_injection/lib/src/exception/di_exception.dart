sealed class DISetupException implements Exception {
  DISetupException(this.message, this.cause);

  final String? message;
  final Object? cause;
}

class PreDISetupException extends DISetupException {
  PreDISetupException(super.message, super.cause);
}

class RegisterDISetupException extends DISetupException {
  RegisterDISetupException(super.message, super.cause);
}

class PostDISetupException extends DISetupException {
  PostDISetupException(super.message, super.cause);
}
