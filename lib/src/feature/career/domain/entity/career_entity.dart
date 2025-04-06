import 'package:equatable/equatable.dart';

class CareerEntity extends Equatable {
  const CareerEntity({
    required this.name,
    required this.email,
    required this.role,
    required this.country,
    required this.message,
    required this.resumeName,
    required this.resumeUrl,
    required this.uploadedAt,
    required this.env,
  });

  final String name;
  final String email;
  final String role;
  final String country;
  final String message;
  final String resumeName;
  final String resumeUrl;
  final DateTime uploadedAt;
  final String env;

  @override
  List<Object?> get props => [
        name,
        email,
        role,
        country,
        message,
        resumeName,
        resumeUrl,
        uploadedAt,
        env,
      ];
}
