import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:storybook/src/widget/base_scaffold_widget.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Animated Hover Indicator',
  type: AnimatedHoverIndicator,
)
AnimatedHoverIndicator animatedHoverIndicator(BuildContext context) {
  return const AnimatedHoverIndicator();
}

class AnimatedHoverIndicator extends StatefulWidget {
  const AnimatedHoverIndicator({super.key});

  @override
  State<AnimatedHoverIndicator> createState() => _AnimatedHoverIndicatorState();
}

class _AnimatedHoverIndicatorState extends State<AnimatedHoverIndicator> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldWidget(
      title: 'DSAnimatedHoverIndicator',
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(context.space(factor: 2)),
          child: DSAnimatedHoverIndicator(
            builder: (BuildContext context, bool isHovering) {
              return DsCardWidget(
                backgroundColor: isHovering
                    ? context.colorPalette.backgroundSecondary.surface
                    : context.colorPalette.brand.primary,
                elevation: isHovering
                    ? context.dimen.elevationLevel3
                    : context.dimen.elevationLevel1,
                radius: context.dimen.radiusLevel2,
                child: Padding(
                  padding: EdgeInsets.all(context.space(factor: 2)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DSTextWidget(
                        'Hover capable card',
                        color: context.colorPalette.neutral.grey1,
                        style: context.typography.bodyLarge,
                      ),
                      const DSVerticalSpacerWidget(1),
                      DSTextWidget(
                        'Move your cursor over the card to see the behaviour',
                        color: context.colorPalette.neutral.grey3,
                        style: context.typography.labelSmall,
                      ),
                      const DSVerticalSpacerWidget(1),
                      DSTextWidget(
                        'Hover State: $isHovering',
                        color: context.colorPalette.neutral.grey4,
                        style: context.typography.labelSmall,
                      ),
                    ],
                  ),
                ),
              );
            },
            onHoverChange: (bool value) {
              setState(() => isHovering = value);
            },
          ),
        ),
      ),
    );
  }
}
