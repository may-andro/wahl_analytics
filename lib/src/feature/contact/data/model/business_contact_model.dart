import 'package:json_annotation/json_annotation.dart';

part 'business_contact_model.g.dart';

@JsonSerializable()
class BusinessContactModel {
  const BusinessContactModel({
    required this.email,
    required this.mobileNumber,
    required this.address,
  });

  factory BusinessContactModel.fromJson(Map<String, dynamic> json) =>
      _$BusinessContactModelFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessContactModelToJson(this);

  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'mobileNumber')
  final String mobileNumber;

  @JsonKey(name: 'address')
  final List<String> address;
}
