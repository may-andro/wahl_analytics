import 'package:firestore_content_uploader/logger/log.dart';
import 'package:firestore_content_uploader/use_case/get_api_header_use_case.dart';
import 'package:firestore_content_uploader/use_case/get_base_url_use_case.dart';
import 'package:firestore_content_uploader/use_case/get_data_to_upload_use_case.dart';
import 'package:http/http.dart' as http;

class UploadUseCase {
  UploadUseCase(
    this._baseUrlUseCase,
    this._apiHeaderUseCase,
    this._dataToUploadUseCase,
    this._client,
    this._log,
  );

  final GetBaseUrlUseCase _baseUrlUseCase;
  final GetApiHeaderUseCase _apiHeaderUseCase;
  final GetDataToUploadUseCase _dataToUploadUseCase;
  final http.Client _client;
  final Log _log;

  Future<void> execute(
    String env,
    String documentName,
    String credentialsFilePath,
    String dataFilePath,
  ) async {
    final baseUri = _baseUrlUseCase.execute(documentName, env);
    final headers = await _apiHeaderUseCase.execute(credentialsFilePath);
    final body = await _dataToUploadUseCase.execute(dataFilePath);

    try {
      final response = await _client.patch(
        baseUri,
        headers: headers,
        body: body,
      );
      if (response.statusCode == 200) {
        _log.i('Data uploaded to Firestore successfully');
      } else {
        _log.e('Data upload to Firestore failed: ${response.body}');
      }
    } catch (e) {
      _log.e('Aborting the process due to failure: $e', error: e);
    } finally {
      _client.close();
    }
  }
}
