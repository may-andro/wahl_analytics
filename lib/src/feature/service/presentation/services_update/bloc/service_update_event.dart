import 'package:equatable/equatable.dart';
import 'package:wahl_analytics/src/feature/service/domain/domain.dart';
import 'package:wahl_analytics/src/feature/service/presentation/services_update/dto/servcie_update_form_field_type.dart';

sealed class ServiceUpdateEvent extends Equatable {
  const ServiceUpdateEvent();

  @override
  List<Object> get props => [];
}

final class OnInitServiceUpdateEvent extends ServiceUpdateEvent {
  const OnInitServiceUpdateEvent(this.service);

  final ServiceEntity? service;
}

final class ValidateServiceUpdateTextFieldEvent extends ServiceUpdateEvent {
  const ValidateServiceUpdateTextFieldEvent({
    required this.formFieldType,
    required this.value,
  });

  final ServiceUpdateFormFieldType formFieldType;
  final String? value;
}

final class SelectServiceIconEvent extends ServiceUpdateEvent {
  const SelectServiceIconEvent({required this.icon});

  final String? icon;
}

final class SubmitServiceUpdateFormEvent extends ServiceUpdateEvent {
  const SubmitServiceUpdateFormEvent();
}
