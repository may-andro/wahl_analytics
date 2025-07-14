import 'package:tracking/src/area_controller/area_controller.dart';
import 'package:tracking/src/model/area/area.dart';
import 'package:tracking/src/model/tracking/tracking.dart';

class ScreenViewTracking extends Tracking {
  ScreenViewTracking({required TrackingArea area})
    : super(name: 'screen_view', action: null) {
    TrackingAreaController().currentArea = area;
    _area = area.name;
  }

  late String _area;

  @override
  Map<String, Object> get parameters {
    final params = super.parameters;
    params['area'] = _area;
    return params;
  }
}
