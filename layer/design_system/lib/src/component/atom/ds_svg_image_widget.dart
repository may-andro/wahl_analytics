import 'package:design_system/assets/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum DSSvgAssetImage {
  logo,
  logoLight,
  logoDark;

  const DSSvgAssetImage();
}

class DSSvgImageWidget extends StatelessWidget {
  const DSSvgImageWidget({
    super.key,
    required this.assetImage,
    this.matchTextDirection = false,
    this.bundle,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.allowDrawingOutsideViewBox = false,
    this.placeholderBuilder,
    this.colorFilter,
    this.semanticsLabel,
    this.excludeFromSemantics = false,
    this.clipBehavior = Clip.hardEdge,
  });

  final DSSvgAssetImage assetImage;
  final bool matchTextDirection;
  final AssetBundle? bundle;
  final double? width;
  final double? height;
  final BoxFit fit;
  final AlignmentGeometry alignment;
  final bool allowDrawingOutsideViewBox;
  final WidgetBuilder? placeholderBuilder;
  final ColorFilter? colorFilter;
  final String? semanticsLabel;
  final bool excludeFromSemantics;
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetImage.path,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      colorFilter: colorFilter,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      clipBehavior: clipBehavior,
      package: 'design_system',
    );
  }
}

extension _DSSvgAssetImageExtension on DSSvgAssetImage {
  String get path {
    switch (this) {
      case DSSvgAssetImage.logo:
        return Assets.image.logo.path;
      case DSSvgAssetImage.logoDark:
        return Assets.image.logoDark.path;
      case DSSvgAssetImage.logoLight:
        return Assets.image.logoLight.path;
    }
  }
}
