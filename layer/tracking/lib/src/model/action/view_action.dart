import 'package:tracking/src/model/action/tracking_action.dart';

class ViewAction extends TrackingAction {
  const ViewAction() : super('view');

  @override
  Map<String, dynamic> toJson() => {};
}
