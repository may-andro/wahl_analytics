import 'package:json_annotation/json_annotation.dart';
import 'package:tracking/src/model/action/tracking_action.dart';

part 'setup_action.g.dart';

@JsonSerializable()
class SetupAction extends TrackingAction {
  const SetupAction(this.status) : super('setup');

  @JsonKey(name: 'status')
  final String status;

  @override
  Map<String, dynamic> toJson() => _$SetupActionToJson(this);
}
