import 'package:design_system/design_system.dart';
import 'package:feature_flag/feature_flag.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/src/feature/developer_option/presentation/feature_flag/bloc/bloc.dart';
import 'package:wahl_analytics/src/feature/developer_option/presentation/feature_flag/widget/empty_content_widget.dart';

class FeatureFlagsListWidget extends StatelessWidget {
  const FeatureFlagsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeatureFlagBloc, FeatureFlagState>(
      builder: (context, state) {
        final featureFlags = state.filteredFeatureFlags ?? [];

        if (featureFlags.isEmpty) {
          return EmptyContentWidget(
            message:
                'No feature found for given search query: ${state.searchTerm}',
          );
        }

        if (state.isGrid) {
          return _GridWidget(
            scrollController: state.scrollController,
            featureFlags: featureFlags,
            onClicked: (featureFlags) {
              context.bloc.add(UpdateFFEvent(featureFlag: featureFlags));
            },
          );
        } else {
          return _ListWidget(
            scrollController: state.scrollController,
            featureFlags: featureFlags,
            onClicked: (featureFlags) {
              context.bloc.add(UpdateFFEvent(featureFlag: featureFlags));
            },
          );
        }
      },
    );
  }
}

class _ListWidget extends StatelessWidget {
  const _ListWidget({
    required this.featureFlags,
    required this.onClicked,
    required this.scrollController,
  });

  final List<FeatureFlag> featureFlags;
  final void Function(FeatureFlag) onClicked;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: featureFlags.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final featureFlag = featureFlags[index];
        return SwitchListTile.adaptive(
          title: DSTextWidget(
            featureFlag.feature.title,
            color: featureFlag.isEnabled
                ? context.colorPalette.brand.primary
                : context.colorPalette.neutral.grey7,
            style: context.typography.bodyMedium,
          ),
          subtitle: DSTextWidget(
            featureFlag.feature.key,
            color: featureFlag.isEnabled
                ? context.colorPalette.brand.primary
                : context.colorPalette.neutral.grey6,
            style: context.typography.bodySmall,
          ),
          secondary: Icon(
            featureFlag.feature.icon,
            color: featureFlag.isEnabled
                ? context.colorPalette.brand.primary.color
                : context.colorPalette.neutral.grey7.color,
          ),
          value: featureFlag.isEnabled,
          onChanged: (value) {
            onClicked(FeatureFlag(featureFlag.feature, !featureFlag.isEnabled));
          },
        );
      },
    );
  }
}

class _GridWidget extends StatelessWidget {
  const _GridWidget({
    required this.featureFlags,
    required this.onClicked,
    required this.scrollController,
  });

  final List<FeatureFlag> featureFlags;
  final void Function(FeatureFlag) onClicked;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      controller: scrollController,
      shrinkWrap: true,
      crossAxisCount: 3,
      crossAxisSpacing: context.space(factor: 0.5),
      mainAxisSpacing: context.space(factor: 0.5),
      children: featureFlags.map((featureFlag) {
        return _GridItemWidget(featureFlag: featureFlag, onClicked: onClicked);
      }).toList(),
    );
  }
}

class _GridItemWidget extends StatelessWidget {
  const _GridItemWidget({
    required this.featureFlag,
    required this.onClicked,
  });

  final FeatureFlag featureFlag;
  final void Function(FeatureFlag) onClicked;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onClicked(FeatureFlag(featureFlag.feature, !featureFlag.isEnabled));
      },
      child: Container(
        color: featureFlag.isEnabled
            ? context.colorPalette.brand.primary.color
            : context.colorPalette.neutral.grey3.color,
        padding: EdgeInsets.all(context.space()),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              featureFlag.feature.icon,
              color: featureFlag.isEnabled
                  ? context.colorPalette.brand.onPrimary.color
                  : context.colorPalette.neutral.grey7.color,
            ),
            const DSVerticalSpacerWidget(1),
            Flexible(
              child: DSTextWidget(
                featureFlag.feature.title,
                textAlign: TextAlign.center,
                color: featureFlag.isEnabled
                    ? context.colorPalette.brand.onPrimary
                    : context.colorPalette.neutral.grey7,
                style: context.typography.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
