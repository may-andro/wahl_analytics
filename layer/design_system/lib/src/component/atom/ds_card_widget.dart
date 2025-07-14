import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class DsCardWidget extends StatelessWidget {
  const DsCardWidget({
    super.key,
    required this.child,
    this.backgroundColor,
    this.splashColor,
    this.shadowColor,
    this.surfaceTintColor,
    this.radius,
    this.elevation,
    this.onTap,
    this.margin,
    this.clipBehavior = Clip.antiAlias,
    this.backgroundColorOpacity = 1.0,
  });

  final Widget child;
  final DSColor? backgroundColor;
  final DSColor? shadowColor;
  final DSColor? splashColor;
  final DSColor? surfaceTintColor;
  final DSRadius? radius;
  final DSElevation? elevation;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? margin;
  final Clip clipBehavior;
  final double backgroundColorOpacity;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: splashColor?.color,
      onTap: onTap,
      child: Card(
        color:
            backgroundColor?.color.withValues(alpha: backgroundColorOpacity) ??
            context.colorPalette.background.primary.color.withValues(
              alpha: backgroundColorOpacity,
            ),
        shadowColor: shadowColor?.color,
        surfaceTintColor: surfaceTintColor?.color,
        clipBehavior: clipBehavior,
        elevation: elevation?.value ?? 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius?.value ?? 0),
        ),
        margin: margin ?? EdgeInsets.zero,
        child: child,
      ),
    );
  }
}
