import 'package:design_system/src/component/atom/button/dto/dto.dart';
import 'package:design_system/src/component/atom/button/widget/base_button_widget.dart';
import 'package:flutter/material.dart';

class DSProgressButtonWidget extends StatelessWidget {
  const DSProgressButtonWidget({
    required this.label,
    required this.onPressed,
    this.border = DSProgressButtonBorder.regular,
    this.isDisabled = false,
    this.iconDirection = DSProgressButtonIconDirection.left,
    this.icon,
    this.loadingPercentage,
    this.size = DSProgressButtonSize.large,
    super.key,
  });

  final String label;

  final VoidCallback onPressed;

  final DSProgressButtonBorder border;

  final bool isDisabled;

  final IconData? icon;

  final DSProgressButtonIconDirection iconDirection;

  final double? loadingPercentage;

  final DSProgressButtonSize size;

  @override
  Widget build(BuildContext context) {
    return BaseButtonWidget(
      content: _content,
      onPressed: onPressed,
      variant: PrimaryVariant(),
      border: border.border,
      isDisabled: isDisabled,
      loading: loadingPercentage != null && loadingPercentage! < 1
          ? LinearLoading(loadingPercentage!)
          : null,
      height: size.height,
    );
  }

  ContentDTO get _content {
    final iconData = icon;
    if (iconData == null) {
      return TextContent(label);
    }
    if (iconDirection == DSProgressButtonIconDirection.left) {
      return LeftIconTextContent(label, iconData, size.height * 0.5);
    }
    return RightIconTextContent(label, iconData, size.height * 0.5);
  }
}

enum DSProgressButtonBorder {
  regular,
  rounded;

  BorderDTO get border {
    switch (this) {
      case regular:
        return RegularBorder();
      case rounded:
        return RoundedBorder();
    }
  }
}

enum DSProgressButtonIconDirection { left, right }

enum DSProgressButtonSize {
  small(40),
  medium(48),
  large(54);

  const DSProgressButtonSize(this.height);

  final double height;
}
