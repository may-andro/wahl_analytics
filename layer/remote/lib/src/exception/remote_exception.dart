sealed class RemoteApiException implements Exception {
  const RemoteApiException(this.cause, this.stackTrace);

  final Object cause;
  final StackTrace stackTrace;

  @override
  String toString() {
    return 'RemoteApiException: $cause';
  }
}

/// Thrown when error is in the network layer.
class ApiNetworkException extends RemoteApiException {
  ApiNetworkException(super.cause, super.stackTrace);
}

/// Thrown when the user is not properly authenticated.
class ApiAuthenticationException extends RemoteApiException {
  ApiAuthenticationException(
    this.errorMessage,
    Object cause,
    StackTrace stackTrace,
  ) : super(cause, stackTrace);

  final String errorMessage;
}

/// Thrown when there is error in the client side (I.e. HTTP 4xx).
class ApiClientException extends RemoteApiException {
  ApiClientException(this.errorMessage, Object cause, StackTrace stackTrace)
    : super(cause, stackTrace);

  final String errorMessage;
}

/// Thrown when there is error in the server side (I.e. HTTP 5xx).
class ApiServerException extends RemoteApiException {
  ApiServerException(this.errorMessage, Object cause, StackTrace stackTrace)
    : super(cause, stackTrace);

  final String errorMessage;
}

/// Thrown when there is an unknown error.
class ApiUnknownException extends RemoteApiException {
  ApiUnknownException(super.cause, super.stackTrace);
}

/// Thrown when there is a connection timeout.
class ApiConnectionTimeoutException extends RemoteApiException {
  ApiConnectionTimeoutException(super.cause, super.stackTrace);
}
