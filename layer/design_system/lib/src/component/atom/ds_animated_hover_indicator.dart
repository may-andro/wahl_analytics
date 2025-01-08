import 'package:flutter/material.dart';

class DSAnimatedHoverIndicator extends StatefulWidget {
  const DSAnimatedHoverIndicator({
    required this.builder,
    required this.onHoverChange,
    super.key,
  });

  final Widget Function(BuildContext context, bool isHovering) builder;

  final ValueChanged<bool> onHoverChange;

  @override
  State<DSAnimatedHoverIndicator> createState() =>
      _DSAnimatedHoverIndicatorState();
}

class _DSAnimatedHoverIndicatorState extends State<DSAnimatedHoverIndicator> {
  bool _isHovering = false;

  void _onMouseEnter(bool hovering) {
    setState(() {
      _isHovering = hovering;
    });
    widget.onHoverChange(hovering);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onMouseEnter(true),
      onExit: (_) => _onMouseEnter(false),
      child: widget.builder(context, _isHovering),
    );
  }
}
