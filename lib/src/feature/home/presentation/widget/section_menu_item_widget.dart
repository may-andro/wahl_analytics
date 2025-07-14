import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/src/feature/home/domain/domain.dart';

class SectionMenuItemWidget extends StatefulWidget {
  const SectionMenuItemWidget({
    required this.bodySection,
    this.onTap,
    this.isSelected = false,
    this.isIndicatorEnabled = false,
    super.key,
  });

  final BodySection bodySection;
  final GestureTapCallback? onTap;
  final bool isSelected;
  final bool isIndicatorEnabled;

  @override
  State<SectionMenuItemWidget> createState() => _SectionMenuItemWidgetState();
}

class _SectionMenuItemWidgetState extends State<SectionMenuItemWidget>
    with SingleTickerProviderStateMixin {
  bool _isHovering = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: 450.ms);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textWidth = context.getTextWidth(
      widget.bodySection.name,
      context.typography.bodyLarge,
    );

    return MouseRegion(
      onEnter: (e) => _mouseEnter(true),
      onExit: (e) => _mouseEnter(false),
      child: InkWell(
        onTap: widget.onTap,
        child: Padding(
          padding: EdgeInsets.all(context.space()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DSTextWidget(
                widget.bodySection.name,
                color: _textColor,
                style: context.typography.bodyLarge,
              ),
              if (widget.isIndicatorEnabled) ...[
                if (widget.isSelected)
                  _SelectedIndicatorWidget(width: textWidth * 0.8)
                else
                  _AnimatedHoverIndicatorWidget(
                    isHover: _isHovering,
                    width: textWidth * 0.9,
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _mouseEnter(bool hovering) {
    setState(() {
      _isHovering = hovering;
    });
    if (hovering) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  DSColor get _textColor {
    if (_isHovering) {
      return context.colorPalette.background.onPrimary;
    }

    if (widget.isSelected) {
      return context.colorPalette.background.onPrimary;
    }

    return context.colorPalette.neutral.grey6;
  }
}

class _SelectedIndicatorWidget extends StatelessWidget {
  const _SelectedIndicatorWidget({required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.85,
      child: Container(
        width: width,
        height: context.space(factor: 0.2),
        color: context.colorPalette.background.onPrimary.color,
      ),
    );
  }
}

class _AnimatedHoverIndicatorWidget extends StatelessWidget {
  const _AnimatedHoverIndicatorWidget({
    required this.width,
    required this.isHover,
  });

  final double width;
  final bool isHover;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: isHover ? width : 0,
      height: context.space(factor: 0.2),
      color: context.colorPalette.background.onPrimary.color,
      duration: 300.ms,
      curve: Curves.linearToEaseOut,
    );
  }
}
