import 'package:design_system/design_system.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DSPositionIndicatorWidget extends StatelessWidget {
  const DSPositionIndicatorWidget({
    super.key,
    required this.itemCount,
    required this.indexListener,
  }) : assert(itemCount > 0);

  final int itemCount;
  final ValueListenable<int> indexListener;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.space(factor: 0.5),
      child: AnimatedBuilder(
        animation: indexListener,
        builder: (_, __) {
          return ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: itemCount,
            itemBuilder: (_, pos) {
              return _IndicatorWidget(
                isActive: indexListener.value == pos,
              );
            },
            separatorBuilder: (_, __) => SizedBox(
              width: context.space(factor: 0.5),
            ),
          );
        },
      ),
    );
  }
}

class _IndicatorWidget extends StatelessWidget {
  const _IndicatorWidget({
    required this.isActive,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isActive
            ? context.colorPalette.prominent.primary.color
            : context.colorPalette.neutral.grey3.color,
        borderRadius: BorderRadius.all(
          Radius.circular(context.dimen.radiusCircular.value),
        ),
      ),
      width: context.space(factor: 2),
    );
  }
}
