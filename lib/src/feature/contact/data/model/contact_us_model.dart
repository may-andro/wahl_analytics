import 'package:json_annotation/json_annotation.dart';

part 'contact_us_model.g.dart';

@JsonSerializable()
class ContactUsModel {
  ContactUsModel({
    required this.name,
    required this.email,
    required this.message,
    required this.uploadedAt,
  });

  factory ContactUsModel.fromJson(Map<String, dynamic> json) =>
      _$ContactUsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ContactUsModelToJson(this);

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'uploadedAt')
  final String uploadedAt;

  ContactUsModel copyWith({
    String? name,
    String? email,
    String? message,
    String? uploadedAt,
  }) {
    return ContactUsModel(
      name: name ?? this.name,
      email: email ?? this.email,
      message: message ?? this.message,
      uploadedAt: uploadedAt ?? this.uploadedAt,
    );
  }
}
