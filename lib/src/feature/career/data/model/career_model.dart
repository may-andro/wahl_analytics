import 'package:json_annotation/json_annotation.dart';

part 'career_model.g.dart';

@JsonSerializable()
class CareerModel {
  CareerModel({
    required this.name,
    required this.email,
    required this.role,
    required this.country,
    required this.message,
    required this.resumeUrl,
    required this.uploadedAt,
  });

  factory CareerModel.fromJson(Map<String, dynamic> json) =>
      _$CareerModelFromJson(json);

  Map<String, dynamic> toJson() => _$CareerModelToJson(this);

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'role')
  final String role;

  @JsonKey(name: 'country')
  final String country;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'resumeUrl')
  final String resumeUrl;

  @JsonKey(name: 'uploadedAt')
  final String uploadedAt;

  CareerModel copyWith({
    String? name,
    String? email,
    String? role,
    String? country,
    String? message,
    String? resumeUrl,
    String? uploadedAt,
  }) {
    return CareerModel(
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      country: country ?? this.country,
      message: message ?? this.message,
      resumeUrl: resumeUrl ?? this.resumeUrl,
      uploadedAt: uploadedAt ?? this.uploadedAt,
    );
  }
}
