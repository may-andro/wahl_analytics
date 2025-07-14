import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

typedef ImpressionCallback = void Function();

final Set<String> triggeredImpressions = {};

class TrackingImpressionDetectorWidget extends StatefulWidget {
  const TrackingImpressionDetectorWidget({
    required this.impressionId,
    required this.onImpression,
    required this.child,
    super.key,
  });

  final String impressionId;
  final ImpressionCallback onImpression;
  final Widget child;

  @override
  State<TrackingImpressionDetectorWidget> createState() =>
      _TrackingImpressionDetectorWidgetState();
}

class _TrackingImpressionDetectorWidgetState
    extends State<TrackingImpressionDetectorWidget> {
  final _internalKey = UniqueKey();

  void _handleVisibilityChanged(VisibilityInfo info) {
    final visibleFraction = info.visibleFraction;
    final isVisible = visibleFraction >= 0.1;
    if (!isVisible) return;

    if (triggeredImpressions.contains(widget.impressionId)) return;

    triggeredImpressions.add(widget.impressionId);
    widget.onImpression();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: _internalKey,
      onVisibilityChanged: _handleVisibilityChanged,
      child: widget.child,
    );
  }
}
