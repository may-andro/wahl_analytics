import 'package:design_system/src/foundation/foundation.dart';
import 'package:design_system/src/foundation/typography/font_weight.dart';
import 'package:meta/meta.dart';

@internal
class TypographyImpl implements DSTypography {
  const TypographyImpl();

  @override
  DSTextStyle get displayLarge => const DSTextStyle(
    fontSize: 57.0,
    fontWeight: fontRegular,
    height: 1.12,
    letterSpacing: -0.25,
  );

  @override
  DSTextStyle get displayMedium => const DSTextStyle(
    fontSize: 45.0,
    fontWeight: fontRegular,
    height: 1.16,
    letterSpacing: -0.25,
  );

  @override
  DSTextStyle get displaySmall => const DSTextStyle(
    fontSize: 36.0,
    fontWeight: fontRegular,
    height: 1.22,
    letterSpacing: -0.2,
  );

  @override
  DSTextStyle get headlineLarge => const DSTextStyle(
    fontSize: 32.0,
    fontWeight: fontRegular,
    height: 1.25,
    letterSpacing: -0.15,
  );

  @override
  DSTextStyle get headlineMedium => const DSTextStyle(
    fontSize: 28.0,
    fontWeight: fontRegular,
    height: 1.29,
    letterSpacing: -0.15,
  );

  @override
  DSTextStyle get headlineSmall => const DSTextStyle(
    fontSize: 24.0,
    fontWeight: fontRegular,
    height: 1.33,
    letterSpacing: -0.1,
  );

  @override
  DSTextStyle get titleLarge => const DSTextStyle(
    fontSize: 22.0,
    fontWeight: fontRegular,
    height: 1.27,
    letterSpacing: -0.1,
  );

  @override
  DSTextStyle get titleMedium => const DSTextStyle(
    fontSize: 16.0,
    fontWeight: fontMedium,
    height: 1.5,
    letterSpacing: 0.1,
  );

  @override
  DSTextStyle get titleSmall => const DSTextStyle(
    fontSize: 14.0,
    fontWeight: fontMedium,
    height: 1.43,
    letterSpacing: 0.1,
  );

  @override
  DSTextStyle get bodyLarge => const DSTextStyle(
    fontSize: 16.0,
    fontWeight: fontRegular,
    height: 1.5,
    letterSpacing: 0.5,
  );

  @override
  DSTextStyle get bodyMedium => const DSTextStyle(
    fontSize: 14.0,
    fontWeight: fontRegular,
    height: 1.43,
    letterSpacing: 0.25,
  );

  @override
  DSTextStyle get bodySmall => const DSTextStyle(
    fontSize: 12.0,
    fontWeight: fontRegular,
    height: 1.33,
    letterSpacing: 0.4,
  );

  @override
  DSTextStyle get labelLarge => const DSTextStyle(
    fontSize: 14.0,
    fontWeight: fontMedium,
    height: 1.43,
    letterSpacing: 0.1,
  );

  @override
  DSTextStyle get labelMedium => const DSTextStyle(
    fontSize: 12.0,
    fontWeight: fontMedium,
    height: 1.33,
    letterSpacing: 0.5,
  );

  @override
  DSTextStyle get labelSmall => const DSTextStyle(
    fontSize: 11.0,
    fontWeight: fontMedium,
    height: 1.45,
    letterSpacing: 0.5,
  );
}
