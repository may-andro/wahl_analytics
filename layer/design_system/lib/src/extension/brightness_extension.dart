import 'package:design_system/src/design_system/design_system.dart';
import 'package:design_system/src/extension/design_system_extension.dart';
import 'package:design_system/src/foundation/foundation.dart';
import 'package:flutter/material.dart';

extension BrightnessExtension on Brightness {
  T brightnessMapper<T>({required T light, required T dark}) {
    if (isLightMode) {
      return light;
    }

    return dark;
  }

  DSColorPalette getLightColorPalette(DesignSystem designSystem) {
    return designSystem.lightColorPalette;
  }

  DSColorPalette getDarkColorPalette(DesignSystem designSystem) {
    return designSystem.darkColorPalette;
  }

  bool get isDarkMode => this == Brightness.dark;

  bool get isLightMode => this == Brightness.light;
}
