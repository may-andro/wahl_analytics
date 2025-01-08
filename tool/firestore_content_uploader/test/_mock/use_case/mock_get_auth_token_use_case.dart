import 'package:firestore_content_uploader/use_case/get_auth_token_use_case.dart';
import 'package:mocktail/mocktail.dart';

class MockGetAuthTokenUseCase extends Mock implements GetAuthTokenUseCase {
  void mockExecute(String expected) {
    when(() => execute(any())).thenAnswer((_) async => expected);
  }
}
