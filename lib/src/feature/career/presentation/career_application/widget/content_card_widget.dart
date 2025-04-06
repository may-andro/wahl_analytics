import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class ContentCardWidget extends StatelessWidget {
  const ContentCardWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DsCardWidget(
      backgroundColor: context.colorPalette.background.primary,
      backgroundColorOpacity: 0.9,
      elevation: context.dimen.elevationLevel3,
      radius: context.dimen.radiusLevel2,
      margin: EdgeInsets.all(context.space(factor: 5)),
      child: child,
    );
  }
}
