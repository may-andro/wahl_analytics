import 'package:tracking/src/model/action/action.dart';
import 'package:tracking/src/model/tracking/tracking.dart';

class ViewTracking extends Tracking {
  ViewTracking({required String label})
    : super(
        name: 'view_impression',
        action: ViewAction(label: label),
      );
}
