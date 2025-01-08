import 'package:design_system/assets/assets.gen.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

enum DSAssetImage {
  intro,
  contactUs,
  career;

  const DSAssetImage();
}

class DSAssetImageWidget extends StatelessWidget {
  const DSAssetImageWidget(
    this.assetImage, {
    this.height,
    this.width,
    this.color,
    this.boxFit = BoxFit.cover,
    super.key,
  });

  final DSAssetImage assetImage;
  final double? height;
  final double? width;
  final DSColor? color;
  final BoxFit? boxFit;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      assetImage.path,
      width: width,
      height: height,
      color: color?.color,
      package: 'design_system',
      fit: boxFit,
    );
  }
}

extension _DSAssetImageExtension on DSAssetImage {
  String get path {
    switch (this) {
      case DSAssetImage.intro:
        return Assets.image.homeIntro.path;
      case DSAssetImage.contactUs:
        return Assets.image.contactUs.path;
      case DSAssetImage.career:
        return Assets.image.carrer.path;
    }
  }
}
