import 'package:cloud_functions/cloud_functions.dart';

class FbFunctionException implements Exception {
  const FbFunctionException(this.cause, this.stackTrace);

  final Object cause;
  final StackTrace stackTrace;
}

class FbFunctionController {
  FbFunctionController(this._firebaseFunctions);

  final FirebaseFunctions _firebaseFunctions;

  Future<dynamic> callFunction(
    String name, {
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final callable = _firebaseFunctions.httpsCallable(name);

      final response = await callable.call<dynamic>(parameters ?? {});
      if (response.data == null) {
        throw Exception('No data found');
      }

      return response.data;
    } catch (e, st) {
      throw FbFunctionException(e, st);
    }
  }
}
