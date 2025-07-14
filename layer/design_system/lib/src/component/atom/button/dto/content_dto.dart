import 'package:design_system/src/extension/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@internal
abstract interface class ContentDTO {
  ContentDTO(this.label, {this.left, this.right});

  final String label;
  final IconData? left;
  final IconData? right;

  Widget getContentWidget(BuildContext context, Color iconColor);
}

@internal
class TextContent extends ContentDTO {
  TextContent(super.label) : super(left: null, right: null);

  @override
  Widget getContentWidget(BuildContext context, Color iconColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: context.space(factor: 2)),
        _TextContentWidget(label),
        SizedBox(width: context.space(factor: 2)),
      ],
    );
  }
}

@internal
class LeftIconTextContent extends ContentDTO {
  LeftIconTextContent(super.label, IconData left, this.size)
    : super(left: left, right: null);

  final double size;

  @override
  Widget getContentWidget(BuildContext context, Color iconColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: context.space(factor: 2)),
        _ImageContextWidget(left!, size, iconColor),
        SizedBox(width: context.space(factor: 0.5)),
        _TextContentWidget(label),
        SizedBox(width: context.space(factor: 2)),
      ],
    );
  }
}

@internal
class RightIconTextContent extends ContentDTO {
  RightIconTextContent(super.label, IconData right, this.size)
    : super(left: null, right: right);

  final double size;

  @override
  Widget getContentWidget(BuildContext context, Color iconColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: context.space(factor: 2)),
        _TextContentWidget(label),
        SizedBox(width: context.space(factor: 0.5)),
        _ImageContextWidget(right!, size, iconColor),
        SizedBox(width: context.space(factor: 2)),
      ],
    );
  }
}

class _ImageContextWidget extends StatelessWidget {
  const _ImageContextWidget(this.icon, this.size, this.iconColor);

  final IconData icon;
  final double size;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Icon(icon, size: size, color: iconColor);
  }
}

class _TextContentWidget extends StatelessWidget {
  const _TextContentWidget(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: context.typography.labelLarge.textStyle,
      textHeightBehavior: const TextHeightBehavior(
        applyHeightToFirstAscent: false,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
