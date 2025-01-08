import 'package:design_system/src/theme/ds_theme.dart';
import 'package:flutter/material.dart';

extension DSThemeExtension on DSTheme {
  ThemeData get theme {
    return ThemeData(
      brightness: brightness,
      colorScheme: colorScheme,
      useMaterial3: true,
    );
  }

  ColorScheme get colorScheme {
    return ColorScheme.fromSeed(
      seedColor: colorPalette.brand.primary.color,
    ).copyWith(
      primary: colorPalette.brand.primary.color,
      onPrimary: colorPalette.brand.onPrimary.color,
      primaryContainer: colorPalette.brand.primaryContainer.color,
      onPrimaryContainer: colorPalette.brand.onPrimaryContainer.color,
      secondary: colorPalette.brand.secondary.color,
      onSecondary: colorPalette.brand.onSecondary.color,
      secondaryContainer: colorPalette.brand.secondary.color,
      onSecondaryContainer: colorPalette.brand.onSecondaryContainer.color,
      tertiary: colorPalette.brand.tertiary.color,
      onTertiary: colorPalette.brand.onTertiary.color,
      tertiaryContainer: colorPalette.brand.onTertiaryContainer.color,
      onTertiaryContainer: colorPalette.brand.onTertiaryContainer.color,
      surface: colorPalette.background.surface.color,
      onSurface: colorPalette.background.onSurface.color,
      onSurfaceVariant: colorPalette.background.onSurfaceVariant.color,
      inverseSurface: colorPalette.background.inverseSurface.color,
      onInverseSurface: colorPalette.background.onInverseSurface.color,
      error: colorPalette.semantic.error.color,
      onError: colorPalette.semantic.onError.color,
      errorContainer: colorPalette.semantic.errorContainer.color,
      onErrorContainer: colorPalette.semantic.onErrorContainer.color,
      shadow: colorPalette.background.shadow.color,
      scrim: colorPalette.background.scrim.color,
      brightness: brightness,
    );
  }
}
