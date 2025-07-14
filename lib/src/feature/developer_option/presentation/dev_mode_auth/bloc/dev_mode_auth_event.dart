import 'package:equatable/equatable.dart';

sealed class DevModeAuthEvent extends Equatable {
  const DevModeAuthEvent();

  @override
  List<Object> get props => [];
}

final class OnInitEvent extends DevModeAuthEvent {
  const OnInitEvent();
}

class ValidateTextFieldEvent extends DevModeAuthEvent {
  const ValidateTextFieldEvent({required this.text});

  final String? text;
}

final class SubmitFormEvent extends DevModeAuthEvent {
  const SubmitFormEvent({required this.code, required this.docId});

  final String docId;
  final String code;
}
