import 'package:design_system/src/foundation/typography/ds_text_style.dart';

abstract interface class DSTypography {
  const DSTypography();

  DSTextStyle get displayLarge;

  DSTextStyle get displayMedium;

  DSTextStyle get displaySmall;

  DSTextStyle get headlineLarge;

  DSTextStyle get headlineMedium;

  DSTextStyle get headlineSmall;

  DSTextStyle get titleLarge;

  DSTextStyle get titleMedium;

  DSTextStyle get titleSmall;

  DSTextStyle get bodyLarge;

  DSTextStyle get bodyMedium;

  DSTextStyle get bodySmall;

  DSTextStyle get labelLarge;

  DSTextStyle get labelMedium;

  DSTextStyle get labelSmall;
}
