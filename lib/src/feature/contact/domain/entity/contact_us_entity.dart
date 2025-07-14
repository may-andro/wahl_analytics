import 'package:equatable/equatable.dart';

class ContactUsEntity extends Equatable {
  const ContactUsEntity({
    required this.name,
    required this.email,
    required this.message,
  });

  final String name;
  final String email;
  final String message;

  @override
  List<Object?> get props => [name, email, message];
}
