import 'package:firestore_content_uploader/use_case/get_client_credentials_use_case.dart';
import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:mocktail/mocktail.dart';

class MockGetClientCredentialsUseCase extends Mock
    implements GetClientCredentialsUseCase {
  void mockExecute(ServiceAccountCredentials expected) {
    when(() => execute(any())).thenAnswer((_) async => expected);
  }
}
