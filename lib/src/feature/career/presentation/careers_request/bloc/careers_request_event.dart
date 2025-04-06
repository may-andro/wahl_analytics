import 'package:equatable/equatable.dart';
import 'package:wahl_analytics/src/feature/career/domain/domain.dart';

sealed class CareersRequestEvent extends Equatable {
  const CareersRequestEvent();

  @override
  List<Object> get props => [];
}

final class GetCareersRequestEvent extends CareersRequestEvent {}

final class DeleteCareersRequestEvent extends CareersRequestEvent {
  const DeleteCareersRequestEvent({
    required this.career,
  });

  final CareerEntity career;
}

final class OpenResumeEvent extends CareersRequestEvent {
  const OpenResumeEvent({
    required this.career,
  });

  final CareerEntity career;
}
