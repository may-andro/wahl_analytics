import 'package:equatable/equatable.dart';
import 'package:wahl_analytics/src/feature/service/domain/domain.dart';
import 'package:wahl_analytics/src/feature/service/presentation/services_update/dto/dto.dart';

sealed class ServicesUpdateEvent extends Equatable {
  const ServicesUpdateEvent();

  @override
  List<Object> get props => [];
}

final class GetBusinessServiceEvent extends ServicesUpdateEvent {
  const GetBusinessServiceEvent();
}

class ValidateTextFieldEvent extends ServicesUpdateEvent {
  const ValidateTextFieldEvent({
    required this.formFieldType,
    required this.value,
  });

  final ServicesUpdateFormFieldType formFieldType;
  final String? value;
}

final class SubmitFormEvent extends ServicesUpdateEvent {
  const SubmitFormEvent();
}

final class AddServiceFormEvent extends ServicesUpdateEvent {
  const AddServiceFormEvent(this.service);

  final ServiceEntity service;
}

final class UpdateServiceFormEvent extends ServicesUpdateEvent {
  const UpdateServiceFormEvent(this.service, this.index);

  final ServiceEntity service;
  final int index;
}

final class DeleteServiceFormEvent extends ServicesUpdateEvent {
  const DeleteServiceFormEvent(this.service);

  final ServiceEntity service;
}

final class SelectLocaleEvent extends ServicesUpdateEvent {
  const SelectLocaleEvent(this.locale);

  final String locale;
}

final class ReorderServicePositionEvent extends ServicesUpdateEvent {
  const ReorderServicePositionEvent(
    this.oldIndex,
    this.newIndex,
  );

  final int oldIndex;
  final int newIndex;
}
