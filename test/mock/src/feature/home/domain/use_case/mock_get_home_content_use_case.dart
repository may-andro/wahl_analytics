import 'package:mocktail/mocktail.dart';
import 'package:use_case/use_case.dart';
import 'package:wahl_analytics/src/feature/home/domain/domain.dart';

class MockGetHomeContentUseCase extends Mock implements GetHomeContentUseCase {
  void mockCallSuccess(List<HomeContentEntity> expected) {
    when(call).thenAnswer((_) => Right(expected));
  }

  void mockCallFailure(GetHomeContentFailure failure) {
    when(call).thenAnswer((_) => Left(failure));
  }
}
