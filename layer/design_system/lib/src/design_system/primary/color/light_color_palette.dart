import 'package:design_system/src/foundation/color/color.dart';
import 'package:meta/meta.dart';

@internal
final class LightColorPalette implements DSColorPalette {
  const LightColorPalette();

  @override
  BrandColorScheme get brand {
    return const BrandColorScheme(
      primary: DSColor(0xFF990B2C),
      // Deep Red (Primary)
      onPrimary: DSColor(0xFFFFFFFF),
      // White text for contrast
      primaryContainer: DSColor(0xFFFED9E1),
      // Lightened version for container
      onPrimaryContainer: DSColor(0xFF600718),
      // Darker variant for text on container
      secondary: DSColor(0xFF116466),
      // Deep Teal (Complementary color)
      onSecondary: DSColor(0xFFFFFFFF),
      // White text for contrast
      secondaryContainer: DSColor(0xFFB2E3E4),
      // Lighter teal for container
      onSecondaryContainer: DSColor(0xFF083334),
      // Dark teal for text on container
      tertiary: DSColor(0xFFDAA03D),
      // Warm gold (Analogous color)
      onTertiary: DSColor(0xFFFFFFFF),
      // White text for contrast
      tertiaryContainer: DSColor(0xFFFDE6C5),
      // Light gold for container
      onTertiaryContainer: DSColor(
        0xFF624500,
      ), // Darker variant for text on container
    );
  }

  @override
  NeutralColorScheme get neutral {
    return const NeutralColorScheme(
      black: DSColor(0xFF000000),
      white: DSColor(0xFFFFFFFF),
      grey1: DSColor(0xFFF9F7F7),
      grey2: DSColor(0xFFE3E3E3),
      grey3: DSColor(0xFFCCCCCC),
      grey4: DSColor(0xFFB3B3B3),
      grey5: DSColor(0xFF8C8C8C),
      grey6: DSColor(0xFF616161),
      grey7: DSColor(0xFF3A3A3A),
      grey8: DSColor(0xFF292929),
      grey9: DSColor(0xFF1A1A1A),
      grey10: DSColor(0xFF111112),
    );
  }

  @override
  SemanticColorScheme get semantic {
    return const SemanticColorScheme(
      info: DSColor(0xFF1976D2),
      // Blue (Standard for info)
      onInfo: DSColor(0xFFFFFFFF),
      infoContainer: DSColor(0xFFBBDEFB),
      onInfoContainer: DSColor(0xFF0D47A1),
      success: DSColor(0xFF388E3C),
      // Green for success
      onSuccess: DSColor(0xFFFFFFFF),
      successContainer: DSColor(0xFFC8E6C9),
      onSuccessContainer: DSColor(0xFF1B5E20),
      warning: DSColor(0xFFF57C00),
      // Orange for warning
      onWarning: DSColor(0xFFFFFFFF),
      warningContainer: DSColor(0xFFFFE0B2),
      onWarningContainer: DSColor(0xFF5D3100),
      error: DSColor(0xFFD32F2F),
      // Red for error
      onError: DSColor(0xFFFFFFFF),
      errorContainer: DSColor(0xFFFFCDD2),
      onErrorContainer: DSColor(0xFFB71C1C),
    );
  }

  @override
  BackgroundColorScheme get background {
    return const BackgroundColorScheme(
      primary: DSColor(0xFFF6F6F6),
      // Off-white background, with a very light grey hue
      onPrimary: DSColor(0xFF212121),
      // Dark text on light background
      surface: DSColor(0xFFEFEFEF),
      // Slightly darker off-white for surfaces
      onSurface: DSColor(0xFF424242),
      // Dark grey text on surface
      disabled: DSColor(0xFFD6D6D6),
      // Disabled state grey
      onDisabled: DSColor(0xFF9E9E9E),
      surfaceVariant: DSColor(0xFFE0E0E0),
      // Light grey for variant surfaces
      onSurfaceVariant: DSColor(0xFF616161),
      // Text on variant surfaces
      inverseSurface: DSColor(0xFF121212),
      // Dark inverse background
      onInverseSurface: DSColor(0xFFFFFFFF),
      // Light text on dark inverse surface
      shadow: DSColor(0xFF000000),
      scrim: DSColor(0xFF000000),
    );
  }

  @override
  BackgroundColorScheme get backgroundSecondary {
    return const BackgroundColorScheme(
      primary: DSColor(0xFF212121),
      // Dark grey as contrasting background
      onPrimary: DSColor(0xFFEFEFEF),
      // Light text on dark background
      surface: DSColor(0xFF424242),
      // Slightly lighter dark surface
      onSurface: DSColor(0xFFF6F6F6),
      // Lighter text on darker surface
      disabled: DSColor(0xFF616161),
      // Disabled dark grey
      onDisabled: DSColor(0xFFBDBDBD),
      surfaceVariant: DSColor(0xFF616161),
      // Dark variant
      onSurfaceVariant: DSColor(0xFFD6D6D6),
      inverseSurface: DSColor(0xFFEFEFEF),
      // Light inverse background
      onInverseSurface: DSColor(0xFF212121),
      // Dark text on light inverse surface
      shadow: DSColor(0xFF000000),
      scrim: DSColor(0xFF000000),
    );
  }

  @override
  ProminentColorScheme get prominent {
    return const ProminentColorScheme(
      primary: DSColor(0xFF990B2C),
      // Deep Red (Primary)
      onPrimary: DSColor(0xFFFFFFFF),
      // White text for contrast
      primaryContainer: DSColor(0xFFFED9E1),
      // Lightened version for container
      onPrimaryContainer: DSColor(0xFF600718),
      // Darker variant for text on container
    );
  }
}
