import 'package:design_system/src/design_system/design_system.dart';
import 'package:design_system/src/design_system/primary/primary.dart'
    as primary;
import 'package:design_system/src/foundation/foundation.dart';

extension DesignSystemExtension on DesignSystem {
  DSColorPalette get darkColorPalette {
    switch (this) {
      case DesignSystem.primary:
        return const primary.DarkColorPalette();
    }
  }

  DSColorPalette get lightColorPalette {
    switch (this) {
      case DesignSystem.primary:
        return const primary.LightColorPalette();
    }
  }

  DSDimen get dimen {
    switch (this) {
      case DesignSystem.primary:
        return const primary.DimenImpl();
    }
  }

  DSTypography get typography {
    switch (this) {
      case DesignSystem.primary:
        return const primary.TypographyImpl();
    }
  }
}
