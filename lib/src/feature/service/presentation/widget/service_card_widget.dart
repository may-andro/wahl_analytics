import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/src/feature/service/domain/domain.dart';

class ServiceCardWidget extends StatefulWidget {
  const ServiceCardWidget({
    required this.service,
    this.isContentHorizontallyAligned = false,
    super.key,
  });

  final ServiceEntity service;
  final bool isContentHorizontallyAligned;

  @override
  State<ServiceCardWidget> createState() => _ServiceCardWidgetState();
}

class _ServiceCardWidgetState extends State<ServiceCardWidget>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: 400.ms,
      vsync: this,
    );
    _fadeInAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DSAnimatedHoverIndicator(
      onHoverChange: (bool isHovering) {
        if (isHovering) {
          _animationController.forward();
        } else {
          _animationController.reverse();
        }
      },
      builder: (BuildContext context, bool isHovering) {
        return DsCardWidget(
          backgroundColor: isHovering
              ? context.colorPalette.backgroundSecondary.surface
              : context.colorPalette.backgroundSecondary.primary,
          surfaceTintColor: isHovering
              ? context.colorPalette.prominent.primary
              : context.colorPalette.neutral.transparent,
          elevation: isHovering
              ? context.dimen.elevationLevel3
              : context.dimen.elevationLevel1,
          radius: context.dimen.radiusLevel2,
          child: Padding(
            padding: EdgeInsets.all(context.space(factor: 2)),
            child: widget.isContentHorizontallyAligned
                ? _HorizontalContentWidget(
                    fadeInAnimation: _fadeInAnimation,
                    isHovering: isHovering,
                    service: widget.service,
                  )
                : _VerticalContentWidget(
                    fadeInAnimation: _fadeInAnimation,
                    isHovering: isHovering,
                    service: widget.service,
                  ),
          ),
        );
      },
    );
  }
}

class _HorizontalContentWidget extends StatelessWidget {
  const _HorizontalContentWidget({
    required this.isHovering,
    required this.service,
    required this.fadeInAnimation,
  });

  final bool isHovering;
  final ServiceEntity service;
  final Animation<double> fadeInAnimation;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _IconCardWidget(
          fadeInAnimation: fadeInAnimation,
          isHovering: isHovering,
          service: service,
        ),
        const DSHorizontalSpacerWidget(3),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              DSTextWidget(
                service.title.toUpperCase(),
                color: context.colorPalette.neutral.grey3,
                style: context.typography.titleMedium,
                softWrap: true,
                maxLines: 1,
                textOverflow: TextOverflow.ellipsis,
              ),
              const DSVerticalSpacerWidget(0.5),
              DSTextWidget(
                service.shortDescription,
                color: context.colorPalette.neutral.grey1,
                style: context.typography.labelMedium,
                softWrap: true,
              ),
              const Spacer(),
            ],
          ),
        ),
      ],
    );
  }
}

class _VerticalContentWidget extends StatelessWidget {
  const _VerticalContentWidget({
    required this.isHovering,
    required this.service,
    required this.fadeInAnimation,
  });

  final bool isHovering;
  final ServiceEntity service;
  final Animation<double> fadeInAnimation;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: constraints.maxHeight * 0.5,
                height: constraints.maxHeight * 0.5,
                child: _IconCardWidget(
                  isHovering: isHovering,
                  fadeInAnimation: fadeInAnimation,
                  service: service,
                ),
              ),
            ),
            Positioned(
              top: constraints.maxHeight * 0.6,
              left: 0,
              right: 0,
              bottom: 0,
              child: Column(
                children: [
                  DSTextWidget(
                    service.title.toUpperCase(),
                    color: context.colorPalette.neutral.grey3,
                    style: context.typography.titleMedium,
                    softWrap: true,
                    maxLines: 1,
                    textOverflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                  const DSVerticalSpacerWidget(0.5),
                  Expanded(
                    child: DSTextWidget(
                      service.shortDescription,
                      color: context.colorPalette.neutral.grey1,
                      style: context.typography.labelMedium,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      maxLines: 5,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _IconCardWidget extends StatelessWidget {
  const _IconCardWidget({
    required this.isHovering,
    required this.service,
    required this.fadeInAnimation,
  });

  final bool isHovering;
  final ServiceEntity service;
  final Animation<double> fadeInAnimation;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: DsCardWidget(
        backgroundColor: isHovering
            ? context.colorPalette.background.onPrimary
            : context.colorPalette.background.primary,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: isHovering ? context.dimen.elevationLevel2 : null,
        radius: context.dimen.radiusCircular,
        child: Stack(
          fit: StackFit.expand,
          children: [
            FittedBox(
              child: Padding(
                padding: EdgeInsets.all(context.space()),
                child: Icon(
                  service.icon.customIconData,
                  color: isHovering
                      ? context.colorPalette.background.onPrimary.color
                      : context.colorPalette.prominent.primary.color,
                ),
              ),
            ),
            FittedBox(
              child: Padding(
                padding: EdgeInsets.all(context.space()),
                child: FadeTransition(
                  opacity: fadeInAnimation,
                  child: Icon(
                    Icons.remove_red_eye_rounded,
                    color: context.colorPalette.background.primary.color,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
