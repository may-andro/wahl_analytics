import 'package:core/core.dart';
import 'package:wahl_analytics/src/feature/career/data/model/model.dart';
import 'package:wahl_analytics/src/feature/career/domain/domain.dart';

class CareerMapper implements Mapper<CareerEntity, CareerModel> {
  @override
  CareerModel map(CareerEntity from) {
    return CareerModel(
      name: from.name,
      email: from.email,
      role: from.role,
      country: from.country,
      message: from.message,
      resumeUrl: '',
      uploadedAt: DateTime.now().toFullDateTime,
    );
  }
}
