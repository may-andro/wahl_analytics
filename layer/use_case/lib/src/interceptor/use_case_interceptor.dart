abstract class UseCaseInterceptor {
  void onCall<Param>(String tag, Param param);

  void onSuccess<Type>(String tag, Type result);

  void onError(String tag, Object error, StackTrace? stackTrace);
}
