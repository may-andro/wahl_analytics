import 'package:design_system/src/component/atom/atom.dart';
import 'package:design_system/src/extension/build_context_extension.dart';
import 'package:flutter/material.dart';

class DSErrorCardWidget extends StatelessWidget {
  const DSErrorCardWidget({super.key, this.message, this.onRetryClicked});

  final VoidCallback? onRetryClicked;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: context.colorPalette.background.primary.color,
      padding: EdgeInsets.all(context.space(factor: 3)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.error,
            size: context.space(factor: 5),
            color: context.colorPalette.brand.primary.color,
          ),
          const DSHorizontalSpacerWidget(2),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: DSTextWidget(
                    'Oops…',
                    style: context.typography.headlineMedium,
                    color: context.colorPalette.neutral.grey9,
                  ),
                ),
                const DSVerticalSpacerWidget(1),
                Flexible(
                  child: DSTextWidget(
                    message ?? 'Something went wrong, please try later',
                    style: context.typography.bodyLarge,
                    color: context.colorPalette.neutral.grey7,
                  ),
                ),
                const DSVerticalSpacerWidget(2),
                if (onRetryClicked != null) ...[
                  FittedBox(
                    child: DSButtonWidget(
                      label: 'Retry',
                      onPressed: onRetryClicked!,
                      variant: DSButtonVariant.secondary,
                      size: DSButtonSize.small,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
