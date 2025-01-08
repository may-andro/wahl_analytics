import 'dart:async';

import 'package:design_system/src/component/atom/atom.dart';
import 'package:design_system/src/extension/build_context_extension.dart';
import 'package:design_system/src/foundation/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DSAnimatedTextWidget extends StatefulWidget {
  const DSAnimatedTextWidget({
    required this.texts,
    required this.style,
    required this.color,
    this.textAlign = TextAlign.center,
    super.key,
  });

  final List<String> texts;
  final DSTextStyle style;
  final DSColor color;
  final TextAlign textAlign;

  @override
  State<DSAnimatedTextWidget> createState() => _DSAnimatedTextWidgetState();
}

class _DSAnimatedTextWidgetState extends State<DSAnimatedTextWidget>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;
  late Timer _timer;
  int _currentIndex = 0;
  String _longestText = '';
  double _height = 0;
  double _width = 0;

  @override
  void initState() {
    super.initState();

    _longestText = widget.texts.longestString;

    _animationController = AnimationController(
      duration: 1.seconds,
      vsync: this,
    );
    _fadeInAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _animationController.forward();

    _timer = Timer.periodic(3.seconds, (timer) {
      _startNextAnimation();
    });
  }

  void _startNextAnimation() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % widget.texts.length;
    });

    _animationController.reset();
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (_height == 0 || _width != constraints.maxWidth) {
          _width = constraints.maxWidth;
          final maxLines = _calculateNumberOfLines(
            _longestText,
            widget.style.textStyle,
            _width,
          );
          _height = context.getTextHeight(widget.style, maxLines);
        }
        return SizedBox(
          height: _height,
          child: FadeTransition(
            opacity: _fadeInAnimation,
            child: DSTextWidget(
              widget.texts[_currentIndex],
              style: widget.style,
              color: widget.color,
              textAlign: TextAlign.center,
              softWrap: true,
            ),
          ),
        );
      },
    );
  }

  int _calculateNumberOfLines(
    String text,
    TextStyle textStyle,
    double maxWidth,
  ) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: textStyle),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(maxWidth: maxWidth);

    final lineHeight = textStyle.height ?? 1.0;
    final textHeight = textPainter.size.height;

    final int numberOfLines =
        (textHeight / (textStyle.fontSize! * lineHeight)).ceil();

    return numberOfLines;
  }
}

extension StringsExtension on List<String> {
  String get longestString {
    String longestText = '';
    int maxLength = 0;

    for (final text in this) {
      if (text.length > maxLength) {
        maxLength = text.length;
        longestText = text;
      }
    }

    return longestText;
  }
}
