import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class CareerApplicationEntity extends Equatable {
  const CareerApplicationEntity({
    required this.name,
    required this.email,
    required this.role,
    required this.country,
    required this.message,
    required this.fileData,
    required this.env,
  });

  final String name;
  final String email;
  final String role;
  final String country;
  final String message;
  final Uint8List fileData;
  final String env;

  @override
  List<Object?> get props => [
        name,
        email,
        role,
        country,
        message,
        fileData,
        env,
      ];
}
