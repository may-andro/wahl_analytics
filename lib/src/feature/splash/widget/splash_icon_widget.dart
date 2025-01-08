import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class SplashIconWidget extends StatelessWidget {
  const SplashIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DSResponsiveContainerWidget(
      mobileBuilder: (_) {
        return Animate(
          effects: const [
            ScaleEffect(begin: Offset(1, 1), end: Offset(0.5, 0.5)),
          ],
          child: const _IconWidget(),
        );
      },
      tabletBuilder: (_) {
        return Animate(
          effects: const [
            ScaleEffect(begin: Offset(1, 1), end: Offset(1.5, 1.5)),
          ],
          child: const _IconWidget(),
        );
      },
      desktopBuilder: (_) {
        return Animate(
          effects: const [ScaleEffect(begin: Offset(1, 1), end: Offset(2, 2))],
          child: const _IconWidget(),
        );
      },
    );
  }
}

class _IconWidget extends StatelessWidget {
  const _IconWidget();

  @override
  Widget build(BuildContext context) {
    return DSSvgImageWidget(
      assetImage:
          context.isDarkMode ? DSSvgAssetImage.logoDark : DSSvgAssetImage.logo,
      fit: BoxFit.cover,
      width: 120,
    );
  }
}
