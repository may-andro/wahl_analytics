import 'package:design_system/src/design_system/design_system.dart';
import 'package:design_system/src/extension/brightness_extension.dart';
import 'package:design_system/src/extension/design_system_extension.dart';
import 'package:design_system/src/foundation/foundation.dart';
import 'package:flutter/material.dart';

final class DSTheme {
  DSTheme({required this.brightness, required this.designSystem})
    : _lightColorPalette = brightness.getLightColorPalette(designSystem),
      _darkColorPalette = brightness.getDarkColorPalette(designSystem),
      _typography = designSystem.typography,
      _dimen = designSystem.dimen;

  final Brightness brightness;

  final DesignSystem designSystem;

  final DSColorPalette _lightColorPalette;

  final DSColorPalette _darkColorPalette;

  final DSTypography _typography;

  final DSDimen _dimen;

  DSColorPalette get lightColorPalette => _lightColorPalette;

  DSColorPalette get darkColorPalette => _darkColorPalette;

  DSColorPalette get colorPalette {
    return brightness.brightnessMapper<DSColorPalette>(
      light: lightColorPalette,
      dark: darkColorPalette,
    );
  }

  DSTypography get typography => _typography;

  DSDimen get dimen => _dimen;
}
