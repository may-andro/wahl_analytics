import 'package:core/core.dart';
import 'package:wahl_analytics/src/feature/contact/data/model/model.dart';
import 'package:wahl_analytics/src/feature/contact/domain/domain.dart';

class ContactUsMapper implements Mapper<ContactUsEntity, ContactUsModel> {
  @override
  ContactUsModel map(ContactUsEntity from) {
    return ContactUsModel(
      name: from.name,
      email: from.email,
      message: from.message,
      uploadedAt: DateTime.now().toFullDateTime,
    );
  }
}
