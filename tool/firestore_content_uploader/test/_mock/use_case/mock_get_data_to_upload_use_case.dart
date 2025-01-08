import 'package:firestore_content_uploader/use_case/get_data_to_upload_use_case.dart';
import 'package:mocktail/mocktail.dart';

class MockGetDataToUploadUseCase extends Mock
    implements GetDataToUploadUseCase {
  void mockExecute(String expected) {
    when(() => execute(any())).thenAnswer((_) async => expected);
  }
}
