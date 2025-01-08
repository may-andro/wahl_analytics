import 'package:design_system/src/extension/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@internal
abstract interface class LoadingDTO<T> {
  bool get blockClicks;

  Widget getContentWidget(T param);
}

@internal
class CircularLoading extends LoadingDTO<Color> {
  @override
  bool get blockClicks => true;

  @override
  Widget getContentWidget(Color param) => _LoadingWidget(param);
}

@internal
class LinearLoading extends LoadingDTO<BorderRadiusGeometry> {
  LinearLoading(this.progressPercentage);

  final double progressPercentage;

  @override
  bool get blockClicks => false;

  @override
  Widget getContentWidget(BorderRadiusGeometry param) {
    return _ProgressLoadingWidget(param, progressPercentage);
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget(this.progressColor);

  final Color progressColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.space(factor: 2),
      width: context.space(factor: 2),
      child: CircularProgressIndicator(
        strokeWidth: context.space(factor: 0.25),
        color: progressColor,
      ),
    );
  }
}

class _ProgressLoadingWidget extends StatelessWidget {
  const _ProgressLoadingWidget(this.borderRadius, this.progressPercentage);

  final BorderRadiusGeometry borderRadius;
  final double progressPercentage;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: ClipRRect(
            borderRadius: borderRadius,
            child: LinearProgressIndicator(
              value: progressPercentage,
              valueColor: AlwaysStoppedAnimation<Color>(
                context.colorPalette.brand.primaryContainer.color,
              ),
              backgroundColor: Colors.transparent,
            ),
          ),
        );
      },
    );
  }
}
