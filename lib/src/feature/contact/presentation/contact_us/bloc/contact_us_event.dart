import 'package:equatable/equatable.dart';
import 'package:wahl_analytics/src/feature/contact/presentation/contact_us/dto/dto.dart';

sealed class ContactUsEvent extends Equatable {
  const ContactUsEvent();

  @override
  List<Object> get props => [];
}

final class OnInitEvent extends ContactUsEvent {}

final class OnScreenVisibleEvent extends ContactUsEvent {}

class ValidateTextFieldEvent extends ContactUsEvent {
  const ValidateTextFieldEvent({
    required this.formFieldType,
    required this.value,
  });

  final FormFieldType formFieldType;
  final String? value;
}

final class OnConsentSelectedEvent extends ContactUsEvent {
  const OnConsentSelectedEvent({required this.isConsentGiven});

  final bool isConsentGiven;
}

final class SubmitFormEvent extends ContactUsEvent {
  const SubmitFormEvent();
}

final class OnCloseClickEvent extends ContactUsEvent {
  const OnCloseClickEvent();
}
