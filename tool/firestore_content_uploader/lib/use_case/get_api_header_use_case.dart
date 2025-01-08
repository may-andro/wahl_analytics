import 'package:firestore_content_uploader/use_case/get_auth_token_use_case.dart';

class GetApiHeaderUseCase {
  const GetApiHeaderUseCase(this._authTokenUseCase);

  final GetAuthTokenUseCase _authTokenUseCase;

  Future<Map<String, String>> execute(String path) async {
    final authToken = await _authTokenUseCase.execute(path);
    return <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $authToken',
    };
  }
}
