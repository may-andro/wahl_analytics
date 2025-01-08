import 'package:firebase/firebase.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_verification_model.g.dart';

@JsonSerializable()
class AuthVerificationModel {
  const AuthVerificationModel({
    required this.code,
    required this.createdAt,
  });

  factory AuthVerificationModel.fromJson(Map<String, dynamic> json) =>
      _$AuthVerificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthVerificationModelToJson(this);

  @JsonKey(name: 'code')
  final String code;

  @JsonKey(name: 'createdAt')
  @TimestampConverter()
  final DateTime createdAt;
}

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) {
    return timestamp.toDate();
  }

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}
