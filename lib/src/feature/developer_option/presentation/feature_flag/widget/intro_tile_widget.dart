import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/src/feature/developer_option/presentation/feature_flag/bloc/bloc.dart';

class IntroTileWidget extends StatelessWidget {
  const IntroTileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeatureFlagBloc, FeatureFlagState>(
      builder: (context, state) {
        return ListTile(
          title: DSTextWidget(
            'Feature Toggles (${(state.featureFlags ?? []).length})',
            color: context.colorPalette.neutral.grey9,
            style: context.typography.bodyMedium,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () => context.bloc.add(ResetFFEvent()),
              ),
              IconButton(
                icon: Icon(state.isGrid ? Icons.view_list : Icons.grid_view),
                onPressed: () => context.bloc.add(UpdateListTypeEvent()),
              ),
              IconButton(
                icon: const Icon(
                  Icons.search,
                  semanticLabel: 'searchFeatureToggle',
                ),
                onPressed: () {
                  context.bloc.add(UpdateSearchFieldVisibilityEvent());
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
