import 'package:design_system/src/component/atom/atom.dart';
import 'package:design_system/src/extension/build_context_extension.dart';
import 'package:design_system/src/foundation/foundation.dart';
import 'package:flutter/foundation.dart';
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
      toolbarHeight: getHeight(context),
      title: DSSvgImageWidget(
        assetImage: context.isDarkMode
            ? DSSvgAssetImage.logoDark
            : DSSvgAssetImage.logoLight,
        fit: BoxFit.cover,
        height: context.space(factor: 5),
      ),
      titleSpacing: 0,
      leadingWidth: context.space(factor: 13),
      leading: kIsWeb || onBackClicked == null
          ? null
          : DSIconButtonWidget(
              Icons.close,
              iconColor: context.colorPalette.background.onPrimary,
              buttonColor: context.colorPalette.background.primary,
              onPressed: onBackClicked!,
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
}
