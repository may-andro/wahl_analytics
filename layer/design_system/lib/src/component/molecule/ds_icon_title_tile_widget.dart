import 'package:design_system/src/component/atom/atom.dart';
import 'package:design_system/src/extension/build_context_extension.dart';
import 'package:design_system/src/foundation/foundation.dart';
import 'package:flutter/material.dart';

class DSIconTitleTileWidget extends StatelessWidget {
  const DSIconTitleTileWidget({
    super.key,
    required this.text,
    required this.icon,
    this.textColor,
    this.style,
    this.iconSize,
  });

  final String text;
  final IconData icon;
  final DSColor? textColor;
  final DSTextStyle? style;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: (textColor ?? context.colorPalette.neutral.grey2).color,
          size: iconSize,
        ),
        const DSHorizontalSpacerWidget(2),
        Expanded(
          child: DSTextWidget(
            text,
            color: textColor ?? context.colorPalette.neutral.grey2,
            style: style ?? context.typography.labelLarge,
          ),
        ),
      ],
    );
  }
}
