import 'package:flutter/material.dart';

final class DSTextStyle {
  const DSTextStyle({
    this.fontSize,
    this.fontWeight,
    this.fontStyle,
    this.letterSpacing,
    this.height,
  });

  final double? fontSize;

  final FontWeight? fontWeight;

  final FontStyle? fontStyle;

  final double? letterSpacing;

  final double? height;

  TextStyle get textStyle => TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        height: height,
        letterSpacing: letterSpacing,
        fontStyle: fontStyle,
      );
}
