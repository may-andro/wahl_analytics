import 'package:design_system/src/component/atom/button/dto/dto.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@internal
class BaseButtonWidget extends StatelessWidget {
  const BaseButtonWidget({
    required this.content,
    required this.loading,
    required this.variant,
    required this.border,
    required this.onPressed,
    required this.isDisabled,
    required this.height,
    super.key,
  });

  final ContentDTO content;

  final LoadingDTO<dynamic>? loading;

  final VariantDTO variant;

  final BorderDTO border;

  final VoidCallback onPressed;

  final bool isDisabled;

  final double height;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        fixedSize: WidgetStateProperty.all(Size(double.infinity, height)),
        overlayColor: variant.getOverlayColor(context),
        foregroundColor: variant.getForegroundColor(context, isDisabled),
        backgroundColor: variant.getBackgroundColor(context, isDisabled),
        shape: WidgetStateProperty.resolveWith<OutlinedBorder?>((states) {
          return border.getOutlinedBorder(context);
        }),
        side: variant.getSide(context, isDisabled, loading),
        padding: WidgetStateProperty.all(EdgeInsets.zero),
        elevation: WidgetStateProperty.all(0),
      ),
      onPressed: isDisabled || (loading?.blockClicks ?? false)
          ? null
          : onPressed,
      child: _ButtonChildWidget(
        content: content,
        variant: variant,
        isDisabled: isDisabled,
        loading: loading,
        border: border,
      ),
    );
  }
}

class _ButtonChildWidget extends StatelessWidget {
  const _ButtonChildWidget({
    required this.content,
    required this.loading,
    required this.variant,
    required this.border,
    required this.isDisabled,
  });

  final ContentDTO content;

  final LoadingDTO<dynamic>? loading;

  final VariantDTO variant;

  final BorderDTO border;

  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    if (loading != null) {
      return _getLoadingContent(context);
    }
    return Center(
      child: content.getContentWidget(
        context,
        variant.getDefaultTextColor(context),
      ),
    );
  }

  Widget _getLoadingContent(BuildContext context) {
    final tempLoading = loading;
    if (tempLoading == null) return const SizedBox.shrink();

    if (tempLoading is LinearLoading) {
      return Stack(
        children: [
          if (!isDisabled) ...[
            tempLoading.getContentWidget(border.getBorderRadius(context)),
          ],
          Center(
            child: content.getContentWidget(
              context,
              variant.getDefaultTextColor(context),
            ),
          ),
        ],
      );
    }

    if (tempLoading is CircularLoading) {
      return Center(
        child: tempLoading.getContentWidget(
          isDisabled
              ? variant.getDisabledTextColor(context)
              : variant.getDefaultTextColor(context),
        ),
      );
    }

    return const SizedBox.shrink();
  }
}

extension _VariantDTOExtension on VariantDTO {
  WidgetStateProperty<Color?> getOverlayColor(BuildContext context) {
    return WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
      return states.contains(WidgetState.focused)
          ? getDefaultBackgroundColor(context)
          : getPressedBackgroundColor(context);
    });
  }

  WidgetStateProperty<Color?> getForegroundColor(
    BuildContext context,
    bool isDisabled,
  ) {
    return WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
      if (states.contains(WidgetState.disabled) && isDisabled) {
        return getDisabledTextColor(context);
      }
      if (states.contains(WidgetState.pressed) ||
          states.contains(WidgetState.hovered)) {
        return getPressedTextColor(context);
      }
      return getDefaultTextColor(context);
    });
  }

  WidgetStateProperty<Color?> getBackgroundColor(
    BuildContext context,
    bool isDisabled,
  ) {
    return WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.disabled) && isDisabled) {
        return getDisabledBackgroundColor(context);
      }
      return getDefaultBackgroundColor(context);
    });
  }

  WidgetStateProperty<BorderSide?> getSide(
    BuildContext context,
    bool isDisabled,
    LoadingDTO<dynamic>? loading,
  ) {
    return WidgetStateProperty.resolveWith<BorderSide?>((states) {
      var color = getDefaultBorderColor(context);
      if (states.contains(WidgetState.disabled) && isDisabled) {
        color = getDisabledBorderColor(context);
      }
      if (states.contains(WidgetState.pressed) ||
          states.contains(WidgetState.hovered)) {
        color = getPressedBorderColor(context);
      }
      if (loading != null && loading is LinearLoading) {
        color = Colors.transparent;
      }
      return BorderSide(color: color);
    });
  }
}
