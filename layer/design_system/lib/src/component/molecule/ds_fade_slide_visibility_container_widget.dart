import 'package:design_system/src/component/atom/atom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DSFadeSlideVisibilityContainerWidget extends StatefulWidget {
  const DSFadeSlideVisibilityContainerWidget({
    super.key,
    required this.child,
    required this.uniqueId,
  });

  final Widget child;
  final String uniqueId;

  @override
  State<DSFadeSlideVisibilityContainerWidget> createState() =>
      _DSFadeSlideVisibilityContainerWidgetState();
}

class _DSFadeSlideVisibilityContainerWidgetState
    extends State<DSFadeSlideVisibilityContainerWidget>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;

  late final Animation<double> _fadeInAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: 700.milliseconds,
      vsync: this,
    );

    _fadeInAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.decelerate),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.25), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.decelerate,
          ),
        );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DSVisibilityDetectorWidget(
      key: Key('fade_slide_visibility_container_widget_${widget.uniqueId}'),
      onVisibilityChanged: (visiblePercentage) {
        if (visiblePercentage > 25) {
          _animationController.forward();
        }
      },
      child: FadeTransition(
        opacity: _fadeInAnimation,
        child: SlideTransition(position: _slideAnimation, child: widget.child),
      ),
    );
  }
}
