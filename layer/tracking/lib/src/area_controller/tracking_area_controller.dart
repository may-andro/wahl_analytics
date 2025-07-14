import 'package:tracking/src/impression/tracking_impression_detector_widget.dart';
import 'package:tracking/src/model/area/area.dart';

class TrackingAreaController {
  factory TrackingAreaController() => _instance;

  TrackingAreaController._internal();

  static final TrackingAreaController _instance =
      TrackingAreaController._internal();

  TrackingArea _currentArea = UnknownArea();

  TrackingArea get currentArea => _currentArea;

  set currentArea(TrackingArea area) {
    if (_currentArea != area) {
      _currentArea = area;
      triggeredImpressions.clear();
    }
  }
}
