import 'package:flutter/material.dart';

class AnimationManager {
  AnimationManager({
    required TickerProvider vsync,
    required Duration duration,
  }) {
    _controller = AnimationController(vsync: vsync, duration: duration);
  }

  late final AnimationController _controller;
  late final Map<String, Animation<double>> _animations = {};

  AnimationController get controller => _controller;

  Animation<double>? getAnimation(String key) => _animations[key];

  Animation<double> addScaleAnimation({
    required String key,
    required double start,
    required double end,
  }) {
    _animations[key] = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(start, end, curve: Curves.decelerate),
      ),
    );
    return _animations[key]!;
  }

  Animation<double> addFadeAnimation({
    required String key,
    required double start,
    required double end,
  }) {
    _animations[key] = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(start, end, curve: Curves.easeIn),
      ),
    );
    return _animations[key]!;
  }

  void dispose() {
    _controller.dispose();
  }
}
