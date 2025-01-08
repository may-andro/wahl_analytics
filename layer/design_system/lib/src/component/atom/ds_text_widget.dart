import 'package:design_system/src/foundation/foundation.dart';
import 'package:flutter/material.dart';

class DSTextWidget extends StatelessWidget {
  const DSTextWidget(
    this.data, {
    required this.color,
    required this.style,
    this.decoration = TextDecoration.none,
    this.textAlign = TextAlign.left,
    this.package = 'design_system',
    this.maxLines,
    this.softWrap,
    this.textOverflow,
    this.textHeightBehavior,
    this.fontFamily,
    super.key,
  });

  final String data;
  final DSTextStyle style;
  final DSColor color;
  final TextDecoration decoration;
  final TextAlign textAlign;
  final int? maxLines;
  final bool? softWrap;
  final TextOverflow? textOverflow;
  final TextHeightBehavior? textHeightBehavior;
  final String? fontFamily;
  final String package;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: style.textStyle.copyWith(
        color: color.color,
        decoration: decoration,
        fontFamily: fontFamily,
        package: package,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: textOverflow,
      softWrap: softWrap,
      textHeightBehavior: textHeightBehavior,
    );
  }
}
