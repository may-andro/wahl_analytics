import 'package:design_system/src/component/organism/ds_error_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

enum DSViewState {
  idle,
  error,
  loading;

  bool get isIdle => this == idle;

  bool get isError => this == error;

  bool get isLoading => this == loading;
}

class DSViewStateBuilderWidget extends StatelessWidget {
  const DSViewStateBuilderWidget({
    super.key,
    required this.state,
    required this.loadingBuilder,
    required this.builder,
    this.errorBuilder,
    this.onRetryClicked,
  });

  final DSViewState state;
  final WidgetBuilder loadingBuilder;
  final WidgetBuilder builder;
  final WidgetBuilder? errorBuilder;
  final VoidCallback? onRetryClicked;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(duration: 300.ms, child: _buildContent(context));
  }

  Widget _buildContent(BuildContext context) {
    switch (state) {
      case DSViewState.error:
        if (errorBuilder != null) {
          return errorBuilder!(context);
        }
        return DSErrorCardWidget(onRetryClicked: onRetryClicked);
      case DSViewState.idle:
        return builder(context);
      case DSViewState.loading:
        return loadingBuilder(context);
    }
  }
}
