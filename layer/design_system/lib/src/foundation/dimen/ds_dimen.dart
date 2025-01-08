import 'package:design_system/src/foundation/dimen/ds_elevation.dart';
import 'package:design_system/src/foundation/dimen/ds_grid.dart';
import 'package:design_system/src/foundation/dimen/ds_radius.dart';

abstract interface class DSDimen {
  DSRadius get radiusLevel1;

  DSRadius get radiusLevel2;

  DSRadius get radiusLevel3;

  DSRadius get radiusCircular;

  DSElevation get elevationNone;

  DSElevation get elevationLevel1;

  DSElevation get elevationLevel2;

  DSElevation get elevationLevel3;

  DSGrid get grid;
}
