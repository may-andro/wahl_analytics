import 'package:core/core.dart';
import 'package:wahl_analytics/src/feature/contact/data/model/model.dart';
import 'package:wahl_analytics/src/feature/contact/domain/domain.dart';

class BusinessContactMapper
    implements Mapper<BusinessContactModel, BusinessContactEntity> {
  @override
  BusinessContactEntity map(BusinessContactModel from) {
    return BusinessContactEntity(
      email: from.email,
      mobileNumber: from.mobileNumber,
      address: from.address,
    );
  }
}
