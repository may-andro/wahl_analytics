import 'package:json_annotation/json_annotation.dart';
import 'package:tracking/src/model/action/tracking_action.dart';

part 'click_action.g.dart';

@JsonSerializable()
class ClickAction extends TrackingAction {
  const ClickAction({required this.label, this.value}) : super('click');

  @JsonKey(name: 'label')
  final String label;

  @JsonKey(name: 'value')
  final String? value;

  @override
  Map<String, dynamic> toJson() => _$ClickActionToJson(this);
}
