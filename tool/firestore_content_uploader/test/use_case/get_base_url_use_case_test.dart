import 'package:firestore_content_uploader/use_case/get_base_url_use_case.dart';
import 'package:test/test.dart';

void main() {
  group(GetBaseUrlUseCase, () {
    late GetBaseUrlUseCase getBaseUrlUseCase;

    setUp(() {
      getBaseUrlUseCase = const GetBaseUrlUseCase();
    });
    group('execute', () {
      test('should return the valid Uri', () {
        final testUri = Uri.parse(
          'https://firestore.googleapis.com/v1/projects/wahl-analytics-320bf/databases/(default)/documents/collection/document/',
        );

        final result = getBaseUrlUseCase.execute('collection', 'document');

        expect(result, testUri);
      });
    });
  });
}
