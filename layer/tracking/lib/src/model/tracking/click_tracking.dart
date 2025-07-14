import 'package:tracking/src/model/action/action.dart';
import 'package:tracking/src/model/tracking/tracking.dart';

class ClickTracking extends Tracking {
  ClickTracking({required String label, String? value})
    : super(
        name: 'click',
        action: ClickAction(label: label, value: value),
      );
}
