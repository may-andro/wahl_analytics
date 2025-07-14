import 'package:equatable/equatable.dart';

class BusinessContactEntity extends Equatable {
  const BusinessContactEntity({
    required this.email,
    required this.mobileNumber,
    required this.address,
  });

  final String email;
  final String mobileNumber;
  final List<String> address;

  @override
  List<Object?> get props => [email, mobileNumber, address];
}
