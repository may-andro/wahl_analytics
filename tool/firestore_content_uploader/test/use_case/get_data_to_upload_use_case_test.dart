import 'package:firestore_content_uploader/use_case/get_data_to_upload_use_case.dart';
import 'package:test/test.dart';

void main() {
  group(GetDataToUploadUseCase, () {
    late GetDataToUploadUseCase getDataToUploadUseCase;

    setUp(() {
      getDataToUploadUseCase = const GetDataToUploadUseCase();
    });
    group('execute', () {
      test('should return the valid json', () async {
        const path =
            '../firestore_content_uploader/test/test_data/test_data.json';

        final result = await getDataToUploadUseCase.execute(path);

        const expectedFirestoreJson =
            '{"fields":{"stringKey":{"stringValue":"stringValue"},"intKey":{"integerValue":"42"},"boolKey":{"booleanValue":true},"listKey":{"arrayValue":{"values":[{"stringValue":"item1"},{"mapValue":{"fields":{"nestedKey":{"stringValue":"nestedValue"}}}},{"integerValue":"99"}]}},"mapKey":{"mapValue":{"fields":{"nestedString":{"stringValue":"nestedValue"},"nestedInt":{"integerValue":"100"}}}}}}';

        expect(result, expectedFirestoreJson);
      });
    });
  });
}
