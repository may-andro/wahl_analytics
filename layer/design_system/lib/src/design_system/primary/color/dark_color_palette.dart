import 'package:design_system/src/foundation/color/color.dart';
import 'package:meta/meta.dart';

@internal
final class DarkColorPalette implements DSColorPalette {
  const DarkColorPalette();

  @override
  BrandColorScheme get brand {
    return const BrandColorScheme(
      primary: DSColor(0xFFFED9E1),
      // Lightened red (Primary)
      onPrimary: DSColor(0xFF600718),
      // Darker text on light red
      primaryContainer: DSColor(0xFF990B2C),
      // Deep red container
      onPrimaryContainer: DSColor(0xFFFFFFFF),
      // White text on deep red
      secondary: DSColor(0xFFB2E3E4),
      // Light teal for secondary
      onSecondary: DSColor(0xFF083334),
      secondaryContainer: DSColor(0xFF116466),
      onSecondaryContainer: DSColor(0xFFFFFFFF),
      tertiary: DSColor(0xFFFDE6C5),
      // Light gold
      onTertiary: DSColor(0xFF624500),
      tertiaryContainer: DSColor(0xFFDAA03D),
      onTertiaryContainer: DSColor(0xFFFFFFFF),
    );
  }

  @override
  NeutralColorScheme get neutral {
    return const NeutralColorScheme(
      black: DSColor(0xFF000000),
      white: DSColor(0xFFFFFFFF),
      grey1: DSColor(0xFF111112),
      grey2: DSColor(0xFF1A1A1A),
      grey3: DSColor(0xFF292929),
      grey4: DSColor(0xFF3A3A3A),
      grey5: DSColor(0xFF616161),
      grey6: DSColor(0xFF8C8C8C),
      grey7: DSColor(0xFFB3B3B3),
      grey8: DSColor(0xFFCCCCCC),
      grey9: DSColor(0xFFE3E3E3),
      grey10: DSColor(0xFFF7F7F7),
    );
  }

  @override
  SemanticColorScheme get semantic {
    return const SemanticColorScheme(
      info: DSColor(0xFF82B1FF),
      // Lightened Blue
      onInfo: DSColor(0xFF0D47A1),
      infoContainer: DSColor(0xFF1976D2),
      onInfoContainer: DSColor(0xFFFFFFFF),
      success: DSColor(0xFF81C784),
      // Light Green
      onSuccess: DSColor(0xFF1B5E20),
      successContainer: DSColor(0xFF388E3C),
      onSuccessContainer: DSColor(0xFFFFFFFF),
      warning: DSColor(0xFFFFCC80),
      // Lighter Orange
      onWarning: DSColor(0xFF5D3100),
      warningContainer: DSColor(0xFFF57C00),
      onWarningContainer: DSColor(0xFFFFFFFF),
      error: DSColor(0xFFFF8A80),
      // Light Red
      onError: DSColor(0xFFB71C1C),
      errorContainer: DSColor(0xFFD32F2F),
      onErrorContainer: DSColor(0xFFFFFFFF),
    );
  }

  @override
  BackgroundColorScheme get background {
    return const BackgroundColorScheme(
      primary: DSColor(0xFF1E1E1E),
      // Very dark grey (not pure black) for a softer dark theme
      onPrimary: DSColor(0xFFE0E0E0),
      // Light grey text on dark background
      surface: DSColor(0xFF2C2C2C),
      // Slightly lighter dark grey for surfaces
      onSurface: DSColor(0xFFE6E6E6),
      // Light text on surfaces
      disabled: DSColor(0xFF616161),
      onDisabled: DSColor(0xFF9E9E9E),
      surfaceVariant: DSColor(0xFF303030),
      // Dark variant surfaces
      onSurfaceVariant: DSColor(0xFFB3B3B3),
      // Light text on variant surfaces
      inverseSurface: DSColor(0xFFEFEFEF),
      // Light grey inverse background
      onInverseSurface: DSColor(0xFF121212),
      // Dark text on light inverse background
      shadow: DSColor(0xFF000000),
      scrim: DSColor(0xFF000000),
    );
  }

  @override
  BackgroundColorScheme get backgroundSecondary {
    return const BackgroundColorScheme(
      primary: DSColor(0xFFF6F6F6),
      // Light off-white background for contrast
      onPrimary: DSColor(0xFF212121),
      // Dark text on light background
      surface: DSColor(0xFFEFEFEF),
      // Slightly darker light surface
      onSurface: DSColor(0xFF424242),
      // Darker text on light surface
      disabled: DSColor(0xFFD6D6D6),
      // Disabled light grey
      onDisabled: DSColor(0xFF9E9E9E),
      surfaceVariant: DSColor(0xFFE0E0E0),
      // Light variant
      onSurfaceVariant: DSColor(0xFF616161),
      inverseSurface: DSColor(0xFF121212),
      // Dark inverse background
      onInverseSurface: DSColor(0xFFEFEFEF),
      // Light text on dark inverse surface
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
