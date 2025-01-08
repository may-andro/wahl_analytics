import 'package:firestore_content_uploader/use_case/get_client_credentials_use_case.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;

/// Authenticates the user and returns access credentials
class GetAuthTokenUseCase {
  const GetAuthTokenUseCase(this._client, this._getClientCredentialsUseCase);

  final http.Client _client;
  final GetClientCredentialsUseCase _getClientCredentialsUseCase;

  Future<String> execute(String filePath) async {
    final clientCredentials = await _getClientCredentialsUseCase.execute(
      filePath,
    );
    final scopes = <String>['https://www.googleapis.com/auth/cloud-platform'];

    final credentials = await obtainAccessCredentialsViaServiceAccount(
      clientCredentials,
      scopes,
      _client,
    );

    _client.close();
    return credentials.accessToken.data;
  }
}
