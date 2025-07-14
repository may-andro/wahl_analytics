import 'package:design_system/src/extension/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class DSLoadingWidget extends StatelessWidget {
  const DSLoadingWidget({super.key, required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: context.theme.colorPalette.brand.primary.color,
        size: size,
      ),
    );
  }
}
