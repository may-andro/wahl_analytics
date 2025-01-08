import 'package:equatable/equatable.dart';

class AuthVerificationEntity extends Equatable {
  const AuthVerificationEntity({
    required this.code,
    required this.createdAt,
    required this.validityInMin,
  });

  final String code;
  final DateTime createdAt;
  final int validityInMin;

  @override
  List<Object?> get props {
    return [code, createdAt, validityInMin];
  }
}
