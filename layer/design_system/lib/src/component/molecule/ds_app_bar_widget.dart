import 'package:design_system/src/component/atom/atom.dart';
import 'package:design_system/src/extension/build_context_extension.dart';
import 'package:design_system/src/foundation/foundation.dart';
import 'package:flutter/material.dart';

class DSAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const DSAppBarWidget({
    required this.height,
    this.onBackClicked,
    super.key,
  });

  final double height;
  final VoidCallback? onBackClicked;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.colorPalette.background.primary.color,
      surfaceTintColor: context.colorPalette.neutral.transparent.color,
      shadowColor: context.colorPalette.background.onPrimary.color,
      automaticallyImplyLeading: false,
      centerTitle: true,
      toolbarHeight: height,
      title: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: getPadding(context),
              child: DSIconButtonWidget(
                Icons.close,
                iconColor: context.colorPalette.background.onPrimary,
                buttonColor: context.colorPalette.background.primary,
                onPressed: onBackClicked!,
                size: getIconSize(context),
              ),
            ),
          ),
          Align(
            child: DSSvgImageWidget(
              assetImage: context.isDarkMode
                  ? DSSvgAssetImage.logoDark
                  : DSSvgAssetImage.logoLight,
              fit: BoxFit.cover,
              height: context.space(factor: 5),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize {
    return Size.fromHeight(height);
  }

  static double getHeight(BuildContext context) {
    switch (context.deviceResolution) {
      case DSDeviceResolution.mobile:
        return context.space(factor: 7);
      case DSDeviceResolution.tablet:
        return context.space(factor: 7);
      case DSDeviceResolution.desktop:
        return context.space(factor: 8);
    }
  }

  EdgeInsets getPadding(BuildContext context) {
    switch (context.deviceResolution) {
      case DSDeviceResolution.mobile:
      case DSDeviceResolution.tablet:
        return EdgeInsets.zero;
      case DSDeviceResolution.desktop:
        return EdgeInsets.only(left: context.space(factor: 5));
    }
  }

  DSIconButtonSize getIconSize(BuildContext context) {
    switch (context.deviceResolution) {
      case DSDeviceResolution.mobile:
      case DSDeviceResolution.tablet:
        return DSIconButtonSize.medium;
      case DSDeviceResolution.desktop:
        return DSIconButtonSize.small;
    }
  }
}
