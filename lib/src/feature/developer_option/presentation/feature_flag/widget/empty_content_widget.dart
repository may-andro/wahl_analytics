import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class EmptyContentWidget extends StatelessWidget {
  const EmptyContentWidget({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    const defaultMessage =
        'Please check if the Firebase Console has some published feature flag';
    return Center(
      child: Padding(
        padding: EdgeInsets.all(context.space(factor: 2)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DSTextWidget(
              'No feature flag found',
              color: context.colorPalette.neutral.grey9,
              style: context.typography.titleMedium,
            ),
            DSTextWidget(
              message ?? defaultMessage,
              color: context.colorPalette.neutral.grey7,
              style: context.typography.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
