import 'package:design_system/src/foundation/color/ds_color_scheme.dart';

abstract interface class DSColorPalette {
  BrandColorScheme get brand;

  ProminentColorScheme get prominent;

  SemanticColorScheme get semantic;

  NeutralColorScheme get neutral;

  BackgroundColorScheme get background;

  BackgroundColorScheme get backgroundSecondary;
}
