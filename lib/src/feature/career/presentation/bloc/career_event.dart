import 'package:equatable/equatable.dart';
import 'package:wahl_analytics/src/feature/career/presentation/dto/dto.dart';

sealed class CareerEvent extends Equatable {
  const CareerEvent();

  @override
  List<Object> get props => [];
}

final class InitialiseScreenEvent extends CareerEvent {}

class ValidateTextFieldEvent extends CareerEvent {
  const ValidateTextFieldEvent({
    required this.formFieldType,
    required this.value,
  });

  final FormFieldType formFieldType;
  final String? value;
}

final class OnConsentSelectedEvent extends CareerEvent {
  const OnConsentSelectedEvent({
    required this.isConsentGiven,
  });

  final bool isConsentGiven;
}

final class SubmitFormEvent extends CareerEvent {
  const SubmitFormEvent();
}

final class UploadResumeEvent extends CareerEvent {
  const UploadResumeEvent();
}
