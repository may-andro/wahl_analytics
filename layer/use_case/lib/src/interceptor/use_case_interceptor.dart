abstract class UseCaseInterceptor {
  void onCall<Param>(String tag, Param param);

  void onSuccess<Result>(String tag, Result result);

  void onError(String tag, Object error, StackTrace? stackTrace);
}
