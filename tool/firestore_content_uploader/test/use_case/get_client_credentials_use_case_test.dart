import 'package:firestore_content_uploader/use_case/get_client_credentials_use_case.dart';
import 'package:test/test.dart';

void main() {
  group(GetClientCredentialsUseCase, () {
    late GetClientCredentialsUseCase getClientCredentialsUseCase;

    setUp(() {
      getClientCredentialsUseCase = const GetClientCredentialsUseCase();
    });

    group('execute', () {
      test('should return ServiceAccountCredentials', () async {
        const filePath =
            '../firestore_content_uploader/test/test_data/service_account.json';

        final result = await getClientCredentialsUseCase.execute(filePath);

        expect(result, isNotNull);
      });
    });
  });
}
