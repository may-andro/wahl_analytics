import 'package:design_system/src/extension/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DSShimmerLoadingWidget extends StatelessWidget {
  const DSShimmerLoadingWidget({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    final baseColor = context.colorPalette.neutral.grey7.color;
    final highlightColor = context.colorPalette.neutral.grey9.color;
    return SizedBox(
      height: height,
      width: width,
      child: Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        child: ColoredBox(color: baseColor),
      ),
    );
  }
}
