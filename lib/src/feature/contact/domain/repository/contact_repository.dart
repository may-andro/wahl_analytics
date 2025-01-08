import 'package:wahl_analytics/src/feature/contact/domain/entity/entity.dart';

abstract class ContactRepository {
  Future<BusinessContactEntity> getBusinessContact();

  Future<void> submitApplication(ContactUsEntity contactUsEntity);
}
