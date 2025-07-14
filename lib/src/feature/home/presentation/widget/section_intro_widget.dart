import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/src/feature/home/domain/domain.dart';
import 'package:wahl_analytics/src/feature/home/presentation/bloc/bloc.dart';

class SectionIntroWidget extends StatelessWidget {
  const SectionIntroWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final headerSections = state.sections
            ?.whereType<HeaderSection>()
            .toList();
        if (headerSections == null || headerSections.isEmpty) {
          return const SizedBox.shrink();
        }

        final headerSection = headerSections.first;

        return Stack(
          children: [
            Positioned.fill(
              child: DSNetworkImageWidget(
                url: headerSection.urls.last,
                fit: BoxFit.cover,
                errorWidget: const DSAssetImageWidget(DSAssetImage.intro),
                loadingWidget: DSLoadingWidget(size: context.space(factor: 4)),
              ),
            ),
            Positioned.fill(
              child: Container(
                color: context.colorPalette.prominent.primary.color.withValues(
                  alpha: 0.3,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(context.space(factor: 2)),
              child: Center(
                child: Column(
                  children: [
                    const DSVerticalSpacerWidget(2),
                    DSTextWidget(
                      headerSection.title,
                      color: context.colorPalette.neutral.white,
                      style: context.typography.headlineLarge,
                      textAlign: TextAlign.center,
                    ),
                    const DSVerticalSpacerWidget(1),
                    DSAnimatedTextWidget(
                      texts: headerSection.descriptions,
                      color: context.colorPalette.neutral.white,
                      style: context.typography.headlineSmall,
                    ),
                    const DSVerticalSpacerWidget(2),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
