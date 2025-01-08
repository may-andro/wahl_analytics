import 'package:design_system/src/extension/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@internal
abstract interface class ContentDTO {
  ContentDTO(this.label, {this.left, this.right});

  final String label;
  final IconData? left;
  final IconData? right;

  Widget getContentWidget(BuildContext context);
}

@internal
class TextContent extends ContentDTO {
  TextContent(super.label) : super(left: null, right: null);

  @override
  Widget getContentWidget(BuildContext context) {
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
  LeftIconTextContent(
    super.label,
    IconData left,
    this.size,
  ) : super(left: left, right: null);

  final double size;

  @override
  Widget getContentWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: context.space(factor: 2)),
        _ImageContextWidget(left!, size),
        SizedBox(width: context.space(factor: 0.5)),
        _TextContentWidget(label),
        SizedBox(width: context.space(factor: 2)),
      ],
    );
  }
}

@internal
class RightIconTextContent extends ContentDTO {
  RightIconTextContent(
    super.label,
    IconData right,
    this.size,
  ) : super(left: null, right: right);

  final double size;

  @override
  Widget getContentWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: context.space(factor: 2)),
        _TextContentWidget(label),
        SizedBox(width: context.space(factor: 0.5)),
        _ImageContextWidget(right!, size),
        SizedBox(width: context.space(factor: 2)),
      ],
    );
  }
}

class _ImageContextWidget extends StatelessWidget {
  const _ImageContextWidget(
    this.icon,
    this.size,
  );

  final IconData icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Icon(icon, size: size);
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
