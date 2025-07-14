import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/src/feature/home/domain/domain.dart';

class SectionInfoWidget extends StatefulWidget {
  const SectionInfoWidget({
    required this.bodySection,
    required this.isSecondaryBackground,
    required this.onClicked,
    super.key,
  });

  final BodySection bodySection;
  final bool isSecondaryBackground;
  final VoidCallback? onClicked;

  @override
  State<SectionInfoWidget> createState() => _SectionInfoWidgetState();
}

class _SectionInfoWidgetState extends State<SectionInfoWidget>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;

  late final Animation<double> _titleFadeInAnimation;
  late final Animation<double> _descriptionFadeInAnimation;

  late final Animation<double> _buttonScaleAnimation;

  late final Animation<Offset> _titleSlideAnimation;
  late final Animation<Offset> _descriptionSlideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: 700.milliseconds,
      vsync: this,
    );

    _titleFadeInAnimation = _createFadeTransition(0.0, 0.3);
    _titleSlideAnimation = _createSlideTransition(0.0, 0.3);

    _descriptionFadeInAnimation = _createFadeTransition(0.3, 0.7);
    _descriptionSlideAnimation = _createSlideTransition(0.3, 0.7);

    _buttonScaleAnimation = _createScaleTransition(0.7, 1.0);
  }

  Animation<double> _createFadeTransition(double start, double end) {
    return Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(start, end, curve: Curves.fastOutSlowIn),
      ),
    );
  }

  Animation<Offset> _createSlideTransition(double start, double end) {
    return Tween<Offset>(begin: const Offset(0, 1.0), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(start, end, curve: Curves.decelerate),
      ),
    );
  }

  Animation<double> _createScaleTransition(double start, double end) {
    return Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(start, end, curve: Curves.bounceInOut),
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
      key: Key(widget.bodySection.runtimeType.toString()),
      onVisibilityChanged: (visiblePercentage) {
        if (visiblePercentage > 25) {
          _animationController.forward();
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildAnimatedText(
            slideAnimation: _titleSlideAnimation,
            fadeAnimation: _titleFadeInAnimation,
            text: widget.bodySection.title,
            color: widget.isSecondaryBackground
                ? context.colorPalette.neutral.grey1
                : context.colorPalette.neutral.grey9,
            style: context.typography.headlineMedium,
          ),
          const DSVerticalSpacerWidget(1),
          _buildAnimatedText(
            slideAnimation: _descriptionSlideAnimation,
            fadeAnimation: _descriptionFadeInAnimation,
            text: widget.bodySection.description,
            color: widget.isSecondaryBackground
                ? context.colorPalette.neutral.grey3
                : context.colorPalette.neutral.grey7,
            style: context.typography.bodyMedium,
            paddingRight: context.width * _getLeftPaddingFactor(context),
          ),
          if (widget.onClicked != null) ...[
            const DSVerticalSpacerWidget(2),
            _buildAnimatedButton(),
          ],
        ],
      ),
    );
  }

  Widget _buildAnimatedText({
    required Animation<Offset> slideAnimation,
    required Animation<double> fadeAnimation,
    required String text,
    required DSColor color,
    required DSTextStyle style,
    double paddingRight = 0.0,
  }) {
    return SlideTransition(
      position: slideAnimation,
      child: FadeTransition(
        opacity: fadeAnimation,
        child: Padding(
          padding: EdgeInsets.only(right: paddingRight),
          child: DSTextWidget(text, color: color, style: style),
        ),
      ),
    );
  }

  Widget _buildAnimatedButton() {
    return FittedBox(
      child: ScaleTransition(
        scale: _buttonScaleAnimation,
        child: DSButtonWidget(
          label: widget.bodySection.action,
          onPressed: widget.onClicked!,
          variant: DSButtonVariant.prominent,
          size: DSButtonSize.small,
        ),
      ),
    );
  }

  double _getLeftPaddingFactor(BuildContext context) {
    switch (context.deviceResolution) {
      case DSDeviceResolution.mobile:
        return 0;
      case DSDeviceResolution.tablet:
        return 0.1;
      case DSDeviceResolution.desktop:
        return 0.3;
    }
  }
}
