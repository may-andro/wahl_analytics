import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class CareerEntity extends Equatable {
  const CareerEntity({
    required this.name,
    required this.email,
    required this.role,
    required this.country,
    required this.message,
    required this.fileData,
  });

  final String name;
  final String email;
  final String role;
  final String country;
  final String message;
  final Uint8List fileData;

  @override
  List<Object?> get props => [
        name,
        email,
        role,
        country,
        message,
        fileData,
      ];
}
