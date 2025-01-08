import 'package:firestore_content_uploader/use_case/get_base_url_use_case.dart';
import 'package:mocktail/mocktail.dart';

class MockGetBaseUrlUseCase extends Mock implements GetBaseUrlUseCase {
  void mockExecute(Uri expected) {
    when(() => execute(any(), any())).thenReturn(expected);
  }
}
