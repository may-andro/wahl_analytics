import 'dart:math';

import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/l10n/l10n.dart';

class DateHeaderWidget extends StatelessWidget {
  const DateHeaderWidget({
    required this.leftLabel,
    required this.applicationCount,
    super.key,
  });

  final String leftLabel;
  final int applicationCount;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        minHeight: context.space(factor: 4),
        maxHeight: context.space(factor: 5),
        child: Container(
          color: context.colorPalette.prominent.primary.color,
          padding: EdgeInsets.symmetric(horizontal: context.space(factor: 2)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DSTextWidget(
                leftLabel,
                color: context.colorPalette.prominent.onPrimary,
                style: context.typography.bodyMedium,
                softWrap: true,
                maxLines: 1,
                textOverflow: TextOverflow.ellipsis,
              ),
              if (applicationCount > 1) ...[
                DSTextWidget(
                  context.localizations.careersRequestApplication(
                    '$applicationCount',
                  ),
                  color: context.colorPalette.prominent.onPrimary,
                  style: context.typography.bodySmall,
                  softWrap: true,
                  maxLines: 1,
                  textOverflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
