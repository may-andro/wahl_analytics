// ignore: directives_ordering
import 'package:tracking/src/area_controller/area_controller.dart';
import 'package:tracking/src/model/action/action.dart';

export 'app_initialization_tracking.dart';

// ignore: directives_ordering
export 'app_start_tracking.dart';

// ignore: directives_ordering
export 'click_tracking.dart';

// ignore: directives_ordering
export 'screen_view_tracking.dart';

// ignore: directives_ordering
export 'view_tracking.dart';

class Tracking {
  Tracking({required this.name, required this.action})
    : area = TrackingAreaController().currentArea.name;

  final String name;
  final TrackingAction? action;
  final String area;

  Map<String, Object> get parameters {
    final parameters = <String, Object>{'event': name, 'area': area};
    if (action case final TrackingAction action) {
      if (action.action != null) {
        parameters['action'] = action.action!;
      }
      parameters.addAll(action.parameters);
    }
    return parameters;
  }
}
