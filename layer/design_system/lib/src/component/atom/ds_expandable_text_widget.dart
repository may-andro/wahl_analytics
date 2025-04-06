import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class DSExpandableTextWidget extends StatelessWidget {
  const DSExpandableTextWidget(
    this.text, {
    required this.style,
    required this.trimCollapsedText,
    required this.trimExpandedText,
    required this.textColor,
    required this.collapsedTextColor,
    required this.expandedTextColor,
    this.maxLines = 2,
    this.isExpandable = true,
    super.key,
  });

  final String text;
  final DSTextStyle style;
  final DSColor textColor;
  final DSColor collapsedTextColor;
  final DSColor expandedTextColor;
  final String trimCollapsedText;
  final String trimExpandedText;
  final int maxLines;
  final bool isExpandable;

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      text,
      style: style.textStyle.copyWith(color: textColor.color),
      trimMode: TrimMode.Line,
      trimLines: maxLines,
      colorClickableText: context.colorPalette.prominent.primary.color,
      trimCollapsedText: trimCollapsedText,
      trimExpandedText: trimExpandedText,
      moreStyle: style.textStyle.copyWith(color: collapsedTextColor.color),
      lessStyle: style.textStyle.copyWith(color: expandedTextColor.color),
      isExpandable: isExpandable,
    );
  }
}
