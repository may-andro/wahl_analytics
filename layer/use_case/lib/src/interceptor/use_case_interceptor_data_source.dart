import 'package:use_case/src/interceptor/use_case_interceptor.dart';

class UseCaseInterceptorDataSource {
  UseCaseInterceptorDataSource._();

  static final List<UseCaseInterceptor> _list = [];

  static void registerInterceptor(UseCaseInterceptor interceptor) {
    _list.add(interceptor);
  }

  static List<UseCaseInterceptor> get registeredInterceptorList {
    return _list;
  }
}
