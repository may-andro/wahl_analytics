import 'package:design_system/src/foundation/color/ds_color.dart';

class NeutralColorScheme {
  const NeutralColorScheme({
    required this.white,
    required this.grey1,
    required this.grey2,
    required this.grey3,
    required this.grey4,
    required this.grey5,
    required this.grey6,
    required this.grey7,
    required this.grey8,
    required this.grey9,
    required this.grey10,
    required this.black,
  });

  final DSColor white;

  final DSColor grey1;

  final DSColor grey2;

  final DSColor grey3;

  final DSColor grey4;

  final DSColor grey5;

  final DSColor grey6;

  final DSColor grey7;

  final DSColor grey8;

  final DSColor grey9;

  final DSColor grey10;

  final DSColor black;

  DSColor get transparent => const DSColor(0x00000000);
}

class BackgroundColorScheme {
  const BackgroundColorScheme({
    required this.primary,
    required this.onPrimary,
    required this.surface,
    required this.onSurface,
    required this.disabled,
    required this.onDisabled,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.inverseSurface,
    required this.onInverseSurface,
    required this.shadow,
    required this.scrim,
  });

  final DSColor primary;

  final DSColor onPrimary;

  final DSColor surface;

  final DSColor onSurface;

  final DSColor disabled;

  final DSColor onDisabled;

  final DSColor surfaceVariant;

  final DSColor onSurfaceVariant;

  final DSColor inverseSurface;

  final DSColor onInverseSurface;

  final DSColor shadow;

  final DSColor scrim;
}

class SemanticColorScheme {
  const SemanticColorScheme({
    required this.info,
    required this.onInfo,
    required this.infoContainer,
    required this.onInfoContainer,
    required this.success,
    required this.onSuccess,
    required this.successContainer,
    required this.onSuccessContainer,
    required this.warning,
    required this.onWarning,
    required this.warningContainer,
    required this.onWarningContainer,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
  });

  final DSColor info;

  final DSColor onInfo;

  final DSColor infoContainer;

  final DSColor onInfoContainer;

  final DSColor success;

  final DSColor onSuccess;

  final DSColor successContainer;

  final DSColor onSuccessContainer;

  final DSColor warning;

  final DSColor onWarning;

  final DSColor warningContainer;

  final DSColor onWarningContainer;

  final DSColor error;

  final DSColor onError;

  final DSColor errorContainer;

  final DSColor onErrorContainer;
}

class BrandColorScheme {
  const BrandColorScheme({
    required this.primary,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
  });

  final DSColor primary;

  final DSColor onPrimary;

  final DSColor primaryContainer;

  final DSColor onPrimaryContainer;

  final DSColor secondary;

  final DSColor onSecondary;

  final DSColor secondaryContainer;

  final DSColor onSecondaryContainer;

  final DSColor tertiary;

  final DSColor onTertiary;

  final DSColor tertiaryContainer;

  final DSColor onTertiaryContainer;
}

class ProminentColorScheme {
  const ProminentColorScheme({
    required this.primary,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
  });

  final DSColor primary;

  final DSColor onPrimary;

  final DSColor primaryContainer;

  final DSColor onPrimaryContainer;
}
