import 'package:flutter/material.dart';

class AnimationWrapperWidget extends StatelessWidget {
  const AnimationWrapperWidget({
    required this.animation,
    required this.child,
    this.animationType = AnimationType.scale,
    super.key,
  });

  final Animation<double> animation;
  final Widget child;
  final AnimationType animationType;

  @override
  Widget build(BuildContext context) {
    switch (animationType) {
      case AnimationType.scale:
        return ScaleTransition(scale: animation, child: child);
      case AnimationType.fade:
        return FadeTransition(opacity: animation, child: child);
    }
  }
}

enum AnimationType {
  scale,
  fade,
}
