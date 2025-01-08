import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';
import 'package:design_system/src/foundation/foundation.dart';
import 'package:design_system/src/theme/ds_theme.dart';
import 'package:design_system/src/theme/ds_theme_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

extension BuildContextExtension on BuildContext {
  DSTheme get theme => DSThemeWidget.of(this);

  DSColorPalette get colorPalette => theme.colorPalette;

  DSTypography get typography => theme.typography;

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

  double getTextWidth(
    String text,
    DSTextStyle textStyle,
  ) {
    final textScaler = MediaQuery.textScalerOf(this);
    final renderParagraph = RenderParagraph(
      TextSpan(text: text, style: textStyle.textStyle),
      textDirection: TextDirection.ltr,
      textScaler: textScaler,
    );
    renderParagraph.layout(const BoxConstraints());
    return renderParagraph.getMaxIntrinsicWidth(double.infinity);
  }

  double getTextHeight(
    DSTextStyle textStyle,
    int lines,
  ) {
    final textScaler = MediaQuery.textScalerOf(this);
    final renderParagraph = RenderParagraph(
      TextSpan(
        text: _stringWithAllAsciiCharCodes,
        style: textStyle.textStyle,
      ),
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
