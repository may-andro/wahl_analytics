import 'package:json_annotation/json_annotation.dart';
import 'package:tracking/src/model/action/tracking_action.dart';

part 'view_action.g.dart';

@JsonSerializable()
class ViewAction extends TrackingAction {
  const ViewAction({this.label}) : super('view');

  @JsonKey(name: 'label')
  final String? label;

  @override
  Map<String, dynamic> toJson() => _$ViewActionToJson(this);
}
