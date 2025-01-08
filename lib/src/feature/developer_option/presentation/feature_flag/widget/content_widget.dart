import 'dart:math';

import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/src/feature/developer_option/presentation/feature_flag/bloc/bloc.dart';
import 'package:wahl_analytics/src/feature/developer_option/presentation/feature_flag/widget/empty_content_widget.dart';
import 'package:wahl_analytics/src/feature/developer_option/presentation/feature_flag/widget/feature_flag_list_widget.dart';
import 'package:wahl_analytics/src/feature/developer_option/presentation/feature_flag/widget/intro_tile_widget.dart';
import 'package:wahl_analytics/src/feature/developer_option/presentation/feature_flag/widget/restart_app_tile_widget.dart';
import 'package:wahl_analytics/src/feature/developer_option/presentation/feature_flag/widget/search_field_widget.dart';

class ContentWidget extends StatelessWidget {
  const ContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeatureFlagBloc, FeatureFlagState>(
      buildWhen: (previous, current) => current.viewState != previous.viewState,
      builder: (context, state) {
        return DSViewStateBuilderWidget(
          state: state.viewState,
          loadingBuilder: (_) {
            return DSLoadingWidget(
              size: max(context.shortestSide * 0.1, context.space(factor: 2)),
            );
          },
          errorBuilder: (_) {
            return const DSErrorCardWidget(
              message: 'Something went wrong',
            );
          },
          builder: (_) {
            return const _SuccessStateWidget();
          },
        );
      },
    );
  }
}

class _SuccessStateWidget extends StatelessWidget {
  const _SuccessStateWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeatureFlagBloc, FeatureFlagState>(
      builder: (context, state) {
        final featureFlags = state.featureFlags;

        if (featureFlags == null) {
          return const DSErrorCardWidget(
            message: 'Something went wrong, no feature flags found',
          );
        }

        if (featureFlags.isEmpty) {
          return const EmptyContentWidget();
        }

        return ListView(
          controller: state.scrollController,
          children: const [
            IntroTileWidget(),
            RestartAppTileWidget(),
            SearchFieldWidget(),
            DSVerticalSpacerWidget(1),
            FeatureFlagsListWidget(),
          ],
        );
      },
    );
  }
}
