import 'package:tracking/src/model/action/action.dart';
import 'package:tracking/src/model/tracking/tracking.dart';

class AppInitializationFinishedTracking extends Tracking {
  AppInitializationFinishedTracking({bool isSuccessful = true})
    : super(
        name: 'app_initialization',
        action: SetupAction(
          isSuccessful ? 'Initialized' : 'Initialization Failed',
        ),
      );
}
