import 'package:firestore_content_uploader/use_case/upload_use_case.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../_mock/log/mock_log.dart';
import '../_mock/mock_http_client.dart';
import '../_mock/use_case/mock_get_api_header_use_case.dart';
import '../_mock/use_case/mock_get_base_url_use_case.dart';
import '../_mock/use_case/mock_get_data_to_upload_use_case.dart';

void main() {
  group(UploadUseCase, () {
    late UploadUseCase uploadUseCase;

    late MockGetBaseUrlUseCase mockedGetBaseUrlUseCase;
    late MockGetApiHeaderUseCase mockedGetApiHeaderUseCase;
    late MockGetDataToUploadUseCase mockedGetDataToUploadUseCase;
    late MockHttpClient mockHttpClient;
    late MockLog mockLog;

    setUp(() {
      mockedGetBaseUrlUseCase = MockGetBaseUrlUseCase();
      mockedGetApiHeaderUseCase = MockGetApiHeaderUseCase();
      mockedGetDataToUploadUseCase = MockGetDataToUploadUseCase();
      mockHttpClient = MockHttpClient();
      mockLog = MockLog();

      uploadUseCase = UploadUseCase(
        mockedGetBaseUrlUseCase,
        mockedGetApiHeaderUseCase,
        mockedGetDataToUploadUseCase,
        mockHttpClient,
        mockLog,
      );
    });
    group('execute', () {
      const env = 'prod';
      const document = 'document';
      const credentialsFilePath = 'mock_credentials.json';
      const dataFilePath = 'mock_data.json';
      const mockBaseUrl = 'https://example.com/api';
      const mockHeaders = {'Authorization': 'Bearer mockToken'};
      const mockBody = 'mockData';

      setUp(() {
        mockedGetBaseUrlUseCase.mockExecute(Uri.parse(mockBaseUrl));
        mockedGetApiHeaderUseCase.mockExecute(mockHeaders);
        mockedGetDataToUploadUseCase.mockExecute(mockBody);
      });

      test('should log when the request is success', () async {
        mockHttpClient.mockPatchOK(mockBaseUrl, mockHeaders, mockBody);

        await uploadUseCase.execute(
          env,
          document,
          credentialsFilePath,
          dataFilePath,
        );

        verify(() => mockLog.i(any())).called(1);
        verifyNever(() => mockLog.e(any()));
        verify(() => mockHttpClient.close()).called(1);
      });

      test('should log error when the request is failed', () async {
        mockHttpClient.mockPatchBadRequest(mockBaseUrl, mockHeaders, mockBody);

        await uploadUseCase.execute(
          env,
          document,
          credentialsFilePath,
          dataFilePath,
        );

        verifyNever(() => mockLog.i(any()));
        verify(() => mockLog.e(any())).called(1);
        verify(() => mockHttpClient.close()).called(1);
      });

      test('should throw error when error occurs', () async {
        final error = Exception('Network Error');

        mockHttpClient.mockPatchFailure(
          error,
          mockBaseUrl,
          mockHeaders,
          mockBody,
        );

        await uploadUseCase.execute(
          env,
          document,
          credentialsFilePath,
          dataFilePath,
        );

        verify(
          () => mockLog.e(
            'Aborting the process due to failure: $error',
            error: error,
          ),
        ).called(1);
        verifyNever(() => mockLog.i(any()));
        verify(() => mockHttpClient.close()).called(1);
      });
    });
  });
}
