import 'package:core/core.dart';
import 'package:wahl_analytics/src/feature/career/data/model/model.dart';
import 'package:wahl_analytics/src/feature/career/domain/domain.dart';

class CareerMapper implements BiMapper<CareerModel, CareerEntity> {
  @override
  CareerModel from(CareerEntity from) {
    return CareerModel(
      name: from.name,
      email: from.email,
      role: from.role,
      country: from.country,
      message: from.message,
      resumeName: from.resumeName,
      resumeUrl: from.resumeUrl,
      uploadedAt: from.uploadedAt.toFullDateTime,
      env: from.env,
    );
  }

  @override
  CareerEntity to(CareerModel from) {
    return CareerEntity(
      name: from.name,
      email: from.email,
      role: from.role,
      country: from.country,
      message: from.message,
      resumeName: from.resumeName,
      resumeUrl: from.resumeUrl,
      uploadedAt: from.uploadedAt.toFullDateTime,
      env: from.env,
    );
  }
}
