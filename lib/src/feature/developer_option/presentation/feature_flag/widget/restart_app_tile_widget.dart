import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

import 'package:wahl_analytics/src/feature/developer_option/presentation/feature_flag/bloc/bloc.dart';

class RestartAppTileWidget extends StatelessWidget {
  const RestartAppTileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeatureFlagBloc, FeatureFlagState>(
      buildWhen: (previous, current) =>
          current.isRestartNeeded != previous.isRestartNeeded,
      builder: (context, state) {
        return AnimatedCrossFade(
          firstChild: Container(
            padding: EdgeInsets.only(
              left: context.space(factor: 2),
              right: context.space(factor: 2),
              top: context.space(factor: 2),
            ),
            child: Row(
              children: <Widget>[
                const Icon(Icons.label_important),
                const DSVerticalSpacerWidget(1),
                Expanded(
                  child: DSTextWidget(
                    'Restart required to apply changes',
                    color: context.colorPalette.neutral.grey9,
                    style: context.typography.bodyMedium,
                  ),
                ),
                DSButtonWidget(
                  label: 'Restart',
                  onPressed: () => context.bloc.add(RestartAppEvent()),
                ),
              ],
            ),
          ),
          secondChild: const SizedBox.shrink(),
          crossFadeState: state.isRestartNeeded
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          duration: 500.milliseconds,
        );
      },
    );
  }
}
