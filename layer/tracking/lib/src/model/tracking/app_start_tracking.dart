import 'package:tracking/src/area_controller/area_controller.dart';
import 'package:tracking/src/model/action/action.dart';
import 'package:tracking/src/model/area/area.dart';
import 'package:tracking/src/model/tracking/tracking.dart';

class AppStartTracking extends Tracking {
  AppStartTracking()
    : super(name: 'app_started', action: const SetupAction('uninitialised')) {
    TrackingAreaController().currentArea = SplashArea();
    _area = TrackingAreaController().currentArea.name;
  }

  late String _area;

  @override
  Map<String, Object> get parameters {
    final params = super.parameters;
    params['area'] = _area;
    return params;
  }
}
