import 'package:tracking/src/model/action/action.dart';
import 'package:tracking/src/model/tracking/tracking.dart';

class ViewTracking extends Tracking {
  ViewTracking({required super.name}) : super(action: const ViewAction());
}
