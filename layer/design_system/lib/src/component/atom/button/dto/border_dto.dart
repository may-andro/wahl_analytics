import 'package:design_system/src/extension/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@internal
abstract interface class BorderDTO {
  OutlinedBorder getOutlinedBorder(BuildContext context);

  BorderRadiusGeometry getBorderRadius(BuildContext context);
}

@internal
class RegularBorder extends BorderDTO {
  @override
  OutlinedBorder getOutlinedBorder(BuildContext context) {
    return RoundedRectangleBorder(borderRadius: getBorderRadius(context));
  }

  @override
  BorderRadiusGeometry getBorderRadius(BuildContext context) {
    return BorderRadius.circular(context.dimen.radiusLevel1.value);
  }
}

@internal
class RoundedBorder extends BorderDTO {
  @override
  OutlinedBorder getOutlinedBorder(BuildContext context) {
    return RoundedRectangleBorder(borderRadius: getBorderRadius(context));
  }

  @override
  BorderRadiusGeometry getBorderRadius(BuildContext context) {
    return BorderRadius.circular(context.dimen.radiusCircular.value);
  }
}
