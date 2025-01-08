import 'package:equatable/equatable.dart';

class BusinessSummaryEntity extends Equatable {
  const BusinessSummaryEntity({
    required this.title,
    required this.descriptions,
    required this.urls,
  });

  final String title;
  final List<String> descriptions;
  final List<String> urls;

  @override
  List<Object?> get props => [
        title,
        descriptions,
        urls,
      ];
}
