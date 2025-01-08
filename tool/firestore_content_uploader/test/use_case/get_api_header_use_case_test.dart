import 'package:firestore_content_uploader/use_case/get_api_header_use_case.dart';
import 'package:test/test.dart';

import '../_mock/use_case/mock_get_auth_token_use_case.dart';

void main() {
  group(GetApiHeaderUseCase, () {
    late GetApiHeaderUseCase getApiHeaderUseCase;

    late MockGetAuthTokenUseCase mockedGetAuthTokenUseCase;

    setUp(() {
      mockedGetAuthTokenUseCase = MockGetAuthTokenUseCase();

      getApiHeaderUseCase = GetApiHeaderUseCase(mockedGetAuthTokenUseCase);
    });

    group('execute', () {
      test('should return header map', () async {
        mockedGetAuthTokenUseCase.mockExecute('token');

        final header = await getApiHeaderUseCase.execute('path');

        expect(
          header,
          <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer token',
          },
        );
      });
    });
  });
}
