import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';
import 'package:design_system/src/foundation/foundation.dart';
import 'package:design_system/src/theme/ds_theme.dart';
import 'package:design_system/src/theme/ds_theme_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

extension BuildContextExtension on BuildContext {
  DSTheme get theme => DSThemeWidget.of(this);

  DSColorPalette get colorPalette => theme.colorPalette;

  List<DSColor> get colors => [
    ...neutralColors,
    ...brandColors,
    ...backgroundColors,
    ...backgroundSecondaryColors,
    ...semanticColors,
    ...prominentColors,
  ];

  List<DSColor> get neutralColors => [
    colorPalette.neutral.grey1,
    colorPalette.neutral.grey2,
    colorPalette.neutral.grey3,
    colorPalette.neutral.grey4,
    colorPalette.neutral.grey5,
    colorPalette.neutral.grey6,
    colorPalette.neutral.grey7,
    colorPalette.neutral.grey8,
    colorPalette.neutral.grey9,
    colorPalette.neutral.grey10,
    colorPalette.neutral.white,
    colorPalette.neutral.black,
  ];

  List<DSColor> get brandColors => [
    colorPalette.brand.primary,
    colorPalette.brand.onPrimary,
    colorPalette.brand.primaryContainer,
    colorPalette.brand.onPrimaryContainer,
    colorPalette.brand.secondary,
    colorPalette.brand.onSecondary,
    colorPalette.brand.secondaryContainer,
    colorPalette.brand.onSecondaryContainer,
    colorPalette.brand.tertiary,
    colorPalette.brand.onTertiary,
    colorPalette.brand.tertiaryContainer,
    colorPalette.brand.onTertiaryContainer,
  ];

  List<DSColor> get prominentColors => [
    colorPalette.prominent.primary,
    colorPalette.prominent.onPrimary,
    colorPalette.prominent.primaryContainer,
    colorPalette.prominent.onPrimaryContainer,
  ];

  List<DSColor> get semanticColors => [
    colorPalette.semantic.info,
    colorPalette.semantic.onInfo,
    colorPalette.semantic.infoContainer,
    colorPalette.semantic.onInfoContainer,
    colorPalette.semantic.success,
    colorPalette.semantic.onSuccess,
    colorPalette.semantic.successContainer,
    colorPalette.semantic.onSuccessContainer,
    colorPalette.semantic.warning,
    colorPalette.semantic.onWarning,
    colorPalette.semantic.warningContainer,
    colorPalette.semantic.onWarningContainer,
    colorPalette.semantic.error,
    colorPalette.semantic.onError,
    colorPalette.semantic.errorContainer,
    colorPalette.semantic.onErrorContainer,
  ];

  List<DSColor> get backgroundColors => [
    colorPalette.background.primary,
    colorPalette.background.onPrimary,
    colorPalette.background.surface,
    colorPalette.background.onSurface,
    colorPalette.background.disabled,
    colorPalette.background.onDisabled,
    colorPalette.background.surfaceVariant,
    colorPalette.background.onSurfaceVariant,
    colorPalette.background.inverseSurface,
    colorPalette.background.onInverseSurface,
    colorPalette.background.shadow,
    colorPalette.background.scrim,
  ];

  List<DSColor> get backgroundSecondaryColors => [
    colorPalette.backgroundSecondary.primary,
    colorPalette.backgroundSecondary.onPrimary,
    colorPalette.backgroundSecondary.surface,
    colorPalette.backgroundSecondary.onSurface,
    colorPalette.backgroundSecondary.disabled,
    colorPalette.backgroundSecondary.onDisabled,
    colorPalette.backgroundSecondary.surfaceVariant,
    colorPalette.backgroundSecondary.onSurfaceVariant,
    colorPalette.backgroundSecondary.inverseSurface,
    colorPalette.backgroundSecondary.onInverseSurface,
    colorPalette.backgroundSecondary.shadow,
    colorPalette.backgroundSecondary.scrim,
  ];

  Map<DSColor, String> get colorMap {
    return {
      // Neutral Colors
      colorPalette.neutral.grey1: 'Neutral Grey1',
      colorPalette.neutral.grey2: 'Neutral Grey2',
      colorPalette.neutral.grey3: 'Neutral Grey3',
      colorPalette.neutral.grey4: 'Neutral Grey4',
      colorPalette.neutral.grey5: 'Neutral Grey5',
      colorPalette.neutral.grey6: 'Neutral Grey6',
      colorPalette.neutral.grey7: 'Neutral Grey7',
      colorPalette.neutral.grey8: 'Neutral Grey8',
      colorPalette.neutral.grey9: 'Neutral Grey9',
      colorPalette.neutral.grey10: 'Neutral Grey10',
      colorPalette.neutral.white: 'Neutral White',
      colorPalette.neutral.black: 'Neutral Black',

      // Brand Colors
      colorPalette.brand.primary: 'Brand Primary',
      colorPalette.brand.onPrimary: 'Brand OnPrimary',
      colorPalette.brand.primaryContainer: 'Brand PrimaryContainer',
      colorPalette.brand.onPrimaryContainer: 'Brand OnPrimaryContainer',
      colorPalette.brand.secondary: 'Brand Secondary',
      colorPalette.brand.onSecondary: 'Brand OnSecondary',
      colorPalette.brand.secondaryContainer: 'Brand SecondaryContainer',
      colorPalette.brand.onSecondaryContainer: 'Brand OnSecondaryContainer',
      colorPalette.brand.tertiary: 'Brand Tertiary',
      colorPalette.brand.onTertiary: 'Brand OnTertiary',
      colorPalette.brand.tertiaryContainer: 'Brand TertiaryContainer',
      colorPalette.brand.onTertiaryContainer: 'Brand OnTertiaryContainer',

      // Prominent Colors
      colorPalette.prominent.primary: 'Prominent Primary',
      colorPalette.prominent.onPrimary: 'Prominent OnPrimary',
      colorPalette.prominent.primaryContainer: 'Prominent PrimaryContainer',
      colorPalette.prominent.onPrimaryContainer: 'Prominent OnPrimaryContainer',

      // Semantic Colors
      colorPalette.semantic.info: 'Semantic Info',
      colorPalette.semantic.onInfo: 'Semantic OnInfo',
      colorPalette.semantic.infoContainer: 'Semantic InfoContainer',
      colorPalette.semantic.onInfoContainer: 'Semantic OnInfoContainer',
      colorPalette.semantic.success: 'Semantic Success',
      colorPalette.semantic.onSuccess: 'Semantic OnSuccess',
      colorPalette.semantic.successContainer: 'Semantic SuccessContainer',
      colorPalette.semantic.onSuccessContainer: 'Semantic OnSuccessContainer',
      colorPalette.semantic.warning: 'Semantic Warning',
      colorPalette.semantic.onWarning: 'Semantic OnWarning',
      colorPalette.semantic.warningContainer: 'Semantic WarningContainer',
      colorPalette.semantic.onWarningContainer: 'Semantic OnWarningContainer',
      colorPalette.semantic.error: 'Semantic Error',
      colorPalette.semantic.onError: 'Semantic OnError',
      colorPalette.semantic.errorContainer: 'Semantic ErrorContainer',
      colorPalette.semantic.onErrorContainer: 'Semantic OnErrorContainer',

      // Background Colors
      colorPalette.background.primary: 'Background Primary',
      colorPalette.background.onPrimary: 'Background OnPrimary',
      colorPalette.background.surface: 'Background Surface',
      colorPalette.background.onSurface: 'Background OnSurface',
      colorPalette.background.disabled: 'Background Disabled',
      colorPalette.background.onDisabled: 'Background OnDisabled',
      colorPalette.background.surfaceVariant: 'Background SurfaceVariant',
      colorPalette.background.onSurfaceVariant: 'Background OnSurfaceVariant',
      colorPalette.background.inverseSurface: 'Background InverseSurface',
      colorPalette.background.onInverseSurface: 'Background OnInverseSurface',
      colorPalette.background.shadow: 'Background Shadow',
      colorPalette.background.scrim: 'Background Scrim',

      // Background Secondary Colors
      colorPalette.backgroundSecondary.primary: 'BackgroundSecondary Primary',
      colorPalette.backgroundSecondary.onPrimary:
          'BackgroundSecondary OnPrimary',
      colorPalette.backgroundSecondary.surface: 'BackgroundSecondary Surface',
      colorPalette.backgroundSecondary.onSurface:
          'BackgroundSecondary OnSurface',
      colorPalette.backgroundSecondary.disabled: 'BackgroundSecondary Disabled',
      colorPalette.backgroundSecondary.onDisabled:
          'BackgroundSecondary OnDisabled',
      colorPalette.backgroundSecondary.surfaceVariant:
          'BackgroundSecondary SurfaceVariant',
      colorPalette.backgroundSecondary.onSurfaceVariant:
          'BackgroundSecondary OnSurfaceVariant',
      colorPalette.backgroundSecondary.inverseSurface:
          'BackgroundSecondary InverseSurface',
      colorPalette.backgroundSecondary.onInverseSurface:
          'BackgroundSecondary OnInverseSurface',
      colorPalette.backgroundSecondary.shadow: 'BackgroundSecondary Shadow',
      colorPalette.backgroundSecondary.scrim: 'BackgroundSecondary Scrim',
    };
  }

  DSTypography get typography => theme.typography;

  Map<DSTextStyle, String> get textStyleMap {
    return {
      typography.titleSmall: 'Title Small',
      typography.titleMedium: 'Title Medium',
      typography.titleLarge: 'Title Large',
      typography.bodySmall: 'Body Small',
      typography.bodyMedium: 'Body Medium',
      typography.bodyLarge: 'Body Large',
      typography.labelSmall: 'Label Small',
      typography.labelMedium: 'Label Medium',
      typography.labelLarge: 'Label Large',
      typography.headlineSmall: 'Headline Small',
      typography.headlineMedium: 'Headline Medium',
      typography.headlineLarge: 'Headline Large',
    };
  }

  DSDimen get dimen => theme.dimen;

  double space({double factor = 1}) {
    double deviceFactor = 0;
    switch (deviceResolution) {
      case DSDeviceResolution.mobile:
        deviceFactor = 0;
      case DSDeviceResolution.tablet:
        deviceFactor = 4;
      case DSDeviceResolution.desktop:
        deviceFactor = 8;
    }
    return factor * (theme.dimen.grid.value + deviceFactor) * textScaleFactor;
  }

  double get screenHeight => MediaQuery.of(this).size.height;

  double get screenWidth => MediaQuery.of(this).size.width;

  Size get size => MediaQuery.of(this).size;

  double get width => size.width;

  double get height => size.height;

  EdgeInsets get viewPadding => MediaQuery.of(this).viewPadding;

  double get shortestSide => size.shortestSide;

  Brightness get platformBrightness => MediaQuery.of(this).platformBrightness;

  bool get isDarkMode => platformBrightness == Brightness.dark;

  double get textScaleFactor => MediaQuery.of(this).textScaler.scale(10) / 10;

  bool get isMobile => deviceResolution.isMobile;

  bool get isTablet => deviceResolution.isTablet;

  bool get isDesktop => deviceResolution.isDesktop;

  DSDeviceResolution get deviceResolution {
    switch (getWindowType(this)) {
      case AdaptiveWindowType.xsmall:
        return DSDeviceResolution.mobile;
      case AdaptiveWindowType.small:
        return DSDeviceResolution.tablet;
      case AdaptiveWindowType.medium:
        return DSDeviceResolution.desktop;
      case AdaptiveWindowType.large:
        return DSDeviceResolution.desktop;
      case AdaptiveWindowType.xlarge:
        return DSDeviceResolution.desktop;
      default:
        return DSDeviceResolution.mobile;
    }
  }

  DSDeviceWidthResolution get deviceWidth {
    switch (getWindowType(this)) {
      case AdaptiveWindowType.xsmall:
        return DSDeviceWidthResolution.xs;
      case AdaptiveWindowType.small:
        return DSDeviceWidthResolution.s;
      case AdaptiveWindowType.medium:
        return DSDeviceWidthResolution.m;
      case AdaptiveWindowType.large:
        return DSDeviceWidthResolution.l;
      case AdaptiveWindowType.xlarge:
        return DSDeviceWidthResolution.xl;
      default:
        return DSDeviceWidthResolution.s;
    }
  }

  double getTextWidth(String text, DSTextStyle textStyle) {
    final textScaler = MediaQuery.textScalerOf(this);
    final renderParagraph = RenderParagraph(
      TextSpan(text: text, style: textStyle.textStyle),
      textDirection: TextDirection.ltr,
      textScaler: textScaler,
    );
    renderParagraph.layout(const BoxConstraints());
    return renderParagraph.getMaxIntrinsicWidth(double.infinity);
  }

  double getTextHeight(DSTextStyle textStyle, int lines) {
    final textScaler = MediaQuery.textScalerOf(this);
    final renderParagraph = RenderParagraph(
      TextSpan(text: _stringWithAllAsciiCharCodes, style: textStyle.textStyle),
      textDirection: TextDirection.ltr,
      maxLines: 1,
      strutStyle: StrutStyle.fromTextStyle(textStyle.textStyle),
      textScaler: textScaler,
    );
    renderParagraph.layout(const BoxConstraints());
    return renderParagraph.getMaxIntrinsicHeight(double.infinity) * lines;
  }
}

const _firstPrintableAsciiChar = 32;
const _lastPrintableAsciiChar = 255;
final _stringWithAllAsciiCharCodes = String.fromCharCodes(
  List.generate(
    _lastPrintableAsciiChar - _firstPrintableAsciiChar,
    (index) => _firstPrintableAsciiChar + index,
  ),
);
