import 'package:equatable/equatable.dart';
import 'package:wahl_analytics/src/feature/career/presentation/career_application/dto/dto.dart';

sealed class CareerApplicationEvent extends Equatable {
  const CareerApplicationEvent();

  @override
  List<Object> get props => [];
}

final class OnInitEvent extends CareerApplicationEvent {}

final class ScreenVisibleEvent extends CareerApplicationEvent {}

class ValidateTextFieldEvent extends CareerApplicationEvent {
  const ValidateTextFieldEvent({
    required this.formFieldType,
    required this.value,
  });

  final FormFieldType formFieldType;
  final String? value;
}

final class OnConsentSelectedEvent extends CareerApplicationEvent {
  const OnConsentSelectedEvent({required this.isConsentGiven});

  final bool isConsentGiven;
}

final class SubmitFormEvent extends CareerApplicationEvent {
  const SubmitFormEvent();
}

final class UploadResumeEvent extends CareerApplicationEvent {
  const UploadResumeEvent();
}

final class CloseClickEvent extends CareerApplicationEvent {
  const CloseClickEvent();
}
