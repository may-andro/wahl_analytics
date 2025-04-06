import 'package:flutter/foundation.dart';
import 'package:wahl_analytics/src/feature/career/domain/entity/entity.dart';

abstract class CareerRepository {
  Future<void> submitCareerApplication(
    CareerApplicationEntity careerApplication,
  );

  Future<String> uploadResume(String fileName, Uint8List data);

  Future<List<CareerEntity>> getCareersRequest();

  Future<void> deleteCareerRequest(CareerEntity careerEntity);
}
