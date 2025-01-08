import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class DSMasonStaggeredGridWidget extends StatelessWidget {
  const DSMasonStaggeredGridWidget({
    required this.crossAxisCount,
    required this.itemCount,
    required this.itemBuilder,
    this.mainAxisSpacing = 0,
    this.crossAxisSpacing = 0,
    super.key,
  });

  final int crossAxisCount;
  final int itemCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final Widget Function(BuildContext context, int index) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      mainAxisSpacing: mainAxisSpacing,
      crossAxisSpacing: crossAxisSpacing,
      crossAxisCount: crossAxisCount,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      clipBehavior: Clip.antiAlias,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}
