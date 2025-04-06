import 'package:design_system/src/extension/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@internal
abstract class VariantDTO {
  Color getDefaultBackgroundColor(BuildContext context);

  Color getDefaultBorderColor(BuildContext context);

  Color getDefaultTextColor(BuildContext context);

  Color getDisabledBackgroundColor(BuildContext context);

  Color getDisabledBorderColor(BuildContext context);

  Color getDisabledTextColor(BuildContext context);

  Color getPressedBackgroundColor(BuildContext context);

  Color getPressedBorderColor(BuildContext context);

  Color getPressedTextColor(BuildContext context);
}

@internal
class PrimaryVariant extends VariantDTO {
  @override
  Color getDefaultBackgroundColor(BuildContext context) {
    return context.colorPalette.brand.primaryContainer.color;
  }

  @override
  Color getDefaultBorderColor(BuildContext context) {
    return context.colorPalette.brand.primaryContainer.color;
  }

  @override
  Color getDefaultTextColor(BuildContext context) {
    return context.colorPalette.brand.onPrimaryContainer.color;
  }

  @override
  Color getDisabledBackgroundColor(BuildContext context) {
    return context.colorPalette.background.disabled.color;
  }

  @override
  Color getDisabledBorderColor(BuildContext context) {
    return context.colorPalette.background.disabled.color;
  }

  @override
  Color getDisabledTextColor(BuildContext context) {
    return context.colorPalette.background.onDisabled.color;
  }

  @override
  Color getPressedBackgroundColor(BuildContext context) {
    return context.colorPalette.brand.primary.color;
  }

  @override
  Color getPressedBorderColor(BuildContext context) {
    return context.colorPalette.brand.primary.color;
  }

  @override
  Color getPressedTextColor(BuildContext context) {
    return context.colorPalette.brand.onPrimary.color;
  }
}

@internal
class ProminentVariant extends VariantDTO {
  @override
  Color getDefaultBackgroundColor(BuildContext context) {
    return context.colorPalette.prominent.primary.color;
  }

  @override
  Color getDefaultBorderColor(BuildContext context) {
    return context.colorPalette.prominent.primary.color;
  }

  @override
  Color getDefaultTextColor(BuildContext context) {
    return context.colorPalette.prominent.onPrimary.color;
  }

  @override
  Color getDisabledBackgroundColor(BuildContext context) {
    return context.colorPalette.background.disabled.color;
  }

  @override
  Color getDisabledBorderColor(BuildContext context) {
    return context.colorPalette.background.disabled.color;
  }

  @override
  Color getDisabledTextColor(BuildContext context) {
    return context.colorPalette.background.onDisabled.color;
  }

  @override
  Color getPressedBackgroundColor(BuildContext context) {
    return context.colorPalette.prominent.primaryContainer.color;
  }

  @override
  Color getPressedBorderColor(BuildContext context) {
    return context.colorPalette.prominent.primaryContainer.color;
  }

  @override
  Color getPressedTextColor(BuildContext context) {
    return context.colorPalette.prominent.onPrimaryContainer.color;
  }
}

@internal
class SecondaryVariant extends VariantDTO {
  @override
  Color getDefaultBackgroundColor(BuildContext context) {
    return Colors.transparent;
  }

  @override
  Color getDefaultBorderColor(BuildContext context) {
    return context.colorPalette.brand.secondary.color;
  }

  @override
  Color getDefaultTextColor(BuildContext context) {
    return context.colorPalette.neutral.grey9.color;
  }

  @override
  Color getDisabledBackgroundColor(BuildContext context) {
    return Colors.transparent;
  }

  @override
  Color getDisabledBorderColor(BuildContext context) {
    return context.colorPalette.background.disabled.color;
  }

  @override
  Color getDisabledTextColor(BuildContext context) {
    return context.colorPalette.background.onDisabled.color;
  }

  @override
  Color getPressedBackgroundColor(BuildContext context) {
    return context.colorPalette.brand.secondaryContainer.color;
  }

  @override
  Color getPressedBorderColor(BuildContext context) {
    return context.colorPalette.brand.secondaryContainer.color;
  }

  @override
  Color getPressedTextColor(BuildContext context) {
    return context.colorPalette.brand.onSecondaryContainer.color;
  }
}

@internal
class ErrorVariant extends VariantDTO {
  @override
  Color getDefaultBackgroundColor(BuildContext context) {
    return context.colorPalette.semantic.error.color;
  }

  @override
  Color getDefaultBorderColor(BuildContext context) {
    return context.colorPalette.semantic.error.color;
  }

  @override
  Color getDefaultTextColor(BuildContext context) {
    return context.colorPalette.neutral.white.color;
  }

  @override
  Color getDisabledBackgroundColor(BuildContext context) {
    return context.colorPalette.background.disabled.color;
  }

  @override
  Color getDisabledBorderColor(BuildContext context) {
    return context.colorPalette.background.disabled.color;
  }

  @override
  Color getDisabledTextColor(BuildContext context) {
    return context.colorPalette.background.onDisabled.color;
  }

  @override
  Color getPressedBackgroundColor(BuildContext context) {
    return context.colorPalette.semantic.errorContainer.color;
  }

  @override
  Color getPressedBorderColor(BuildContext context) {
    return context.colorPalette.semantic.errorContainer.color;
  }

  @override
  Color getPressedTextColor(BuildContext context) {
    return context.colorPalette.semantic.onErrorContainer.color;
  }
}

@internal
class TextVariant extends VariantDTO {
  @override
  Color getDefaultBackgroundColor(BuildContext context) {
    return Colors.transparent;
  }

  @override
  Color getDefaultBorderColor(BuildContext context) {
    return Colors.transparent;
  }

  @override
  Color getDefaultTextColor(BuildContext context) {
    return context.colorPalette.neutral.grey9.color;
  }

  @override
  Color getDisabledBackgroundColor(BuildContext context) {
    return Colors.transparent;
  }

  @override
  Color getDisabledBorderColor(BuildContext context) {
    return Colors.transparent;
  }

  @override
  Color getDisabledTextColor(BuildContext context) {
    return context.colorPalette.neutral.grey4.color;
  }

  @override
  Color getPressedBackgroundColor(BuildContext context) {
    return Colors.transparent;
  }

  @override
  Color getPressedBorderColor(BuildContext context) {
    return Colors.transparent;
  }

  @override
  Color getPressedTextColor(BuildContext context) {
    return context.colorPalette.neutral.grey6.color;
  }
}
