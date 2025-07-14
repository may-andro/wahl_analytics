import 'package:json_annotation/json_annotation.dart';
import 'package:tracking/tracking.dart';

part 'drawer_tracking_action.g.dart';

@JsonSerializable()
class DrawerTrackingAction extends TrackingAction {
  const DrawerTrackingAction({required this.status}) : super('drawer');

  @JsonKey(name: 'status')
  final String status;

  @override
  Map<String, dynamic> toJson() => _$DrawerTrackingActionToJson(this);
}
