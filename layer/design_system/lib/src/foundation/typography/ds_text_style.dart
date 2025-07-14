import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

const _firstPrintableAsciiChar = 32;
const _lastPrintableAsciiChar = 255;
final _stringWithAllAsciiCharCodes = String.fromCharCodes(
  List.generate(
    _lastPrintableAsciiChar - _firstPrintableAsciiChar,
    (index) => _firstPrintableAsciiChar + index,
  ),
);

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

  double getTextHeight(BuildContext context, int lines) {
    final textScaler = MediaQuery.textScalerOf(context);
    final renderParagraph = RenderParagraph(
      TextSpan(text: _stringWithAllAsciiCharCodes, style: textStyle),
      textDirection: TextDirection.ltr,
      maxLines: 1,
      strutStyle: StrutStyle.fromTextStyle(textStyle),
      textScaler: textScaler,
    );
    renderParagraph.layout(const BoxConstraints());
    return renderParagraph.getMaxIntrinsicHeight(double.infinity) * lines;
  }

  double getTextWidth(BuildContext context, String text) {
    final textScaler = MediaQuery.textScalerOf(context);
    final renderParagraph = RenderParagraph(
      TextSpan(text: text, style: textStyle),
      textDirection: TextDirection.ltr,
      textScaler: textScaler,
    );
    renderParagraph.layout(const BoxConstraints());
    return renderParagraph.getMaxIntrinsicWidth(double.infinity);
  }
}
