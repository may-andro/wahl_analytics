import 'package:design_system/src/extension/build_context_extension.dart';
import 'package:design_system/src/foundation/foundation.dart';
import 'package:flutter/material.dart';

class DSResponsiveContainerWidget extends StatelessWidget {
  const DSResponsiveContainerWidget({
    required this.mobileBuilder,
    required this.tabletBuilder,
    required this.desktopBuilder,
    super.key,
  });

  final WidgetBuilder mobileBuilder;
  final WidgetBuilder tabletBuilder;
  final WidgetBuilder desktopBuilder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        switch (context.deviceResolution) {
          case DSDeviceResolution.mobile:
            return mobileBuilder(context);
          case DSDeviceResolution.tablet:
            return tabletBuilder(context);
          case DSDeviceResolution.desktop:
            return desktopBuilder(context);
        }
      },
    );
  }
}
