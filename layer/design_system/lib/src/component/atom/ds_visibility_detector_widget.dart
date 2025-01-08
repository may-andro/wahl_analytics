import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class DSVisibilityDetectorWidget extends StatelessWidget {
  const DSVisibilityDetectorWidget({
    required Key key,
    required this.child,
    required this.onVisibilityChanged,
  }) : super(key: key);

  final Widget child;
  final void Function(double) onVisibilityChanged;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: key!,
      onVisibilityChanged: (visibilityInfo) {
        onVisibilityChanged(visibilityInfo.visibleFraction * 100);
      },
      child: child,
    );
  }
}
