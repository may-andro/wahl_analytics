import 'package:core/core.dart';
import 'package:wahl_analytics/src/feature/career/data/model/model.dart';
import 'package:wahl_analytics/src/feature/career/domain/domain.dart';

class CareerApplicationMapper
    implements Mapper<CareerApplicationEntity, CareerModel> {
  @override
  CareerModel map(CareerApplicationEntity from) {
    return CareerModel(
      name: from.name,
      email: from.email,
      role: from.role,
      country: from.country,
      message: from.message,
      resumeName: '',
      resumeUrl: '',
      uploadedAt: DateTime.now().toFullDateTime,
      env: from.env,
    );
  }
}
