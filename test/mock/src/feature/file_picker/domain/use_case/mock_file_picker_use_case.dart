import 'package:mocktail/mocktail.dart';
import 'package:use_case/use_case.dart';
import 'package:wahl_analytics/src/feature/file_picker/domain/domain.dart';

class MockFilePickerUseCase extends Mock implements FilePickerUseCase {
  void mockCallSuccess(PickedFile expected) {
    when(call).thenAnswer((_) async => Right(expected));
  }

  void mockCallFailure(FilePickerFailure failure) {
    when(call).thenAnswer((_) async => Left(failure));
  }
}
