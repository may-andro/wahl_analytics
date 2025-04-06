import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/l10n/l10n.dart';
import 'package:wahl_analytics/src/feature/career/domain/domain.dart';
import 'package:wahl_analytics/src/feature/career/presentation/careers_request/bloc/bloc.dart';
import 'package:wahl_analytics/src/feature/career/presentation/careers_request/widget/career_card_widget.dart';
import 'package:wahl_analytics/src/feature/career/presentation/careers_request/widget/date_header_widget.dart';

class ContentWidget extends StatelessWidget {
  const ContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CareersRequestBloc, CareersRequestState>(
      builder: (context, state) {
        final careerMap = state.careerMap;
        if (careerMap.isEmpty) {
          return _buildEmptyWidget(context);
        }

        final slivers = context.isDesktop
            ? _getDesktopSlivers(context, context.state.careerMap)
            : _getMobileSlivers(context, context.state.careerMap);
        return CustomScrollView(slivers: slivers);
      },
    );
  }

  Widget _buildEmptyWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(_getPadding(context)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Spacer(),
          Icon(
            Icons.mood_bad_rounded,
            color: context.colorPalette.prominent.primary.color,
            size: context.space(factor: 15),
          ),
          const DSVerticalSpacerWidget(5),
          DSTextWidget(
            context.localizations.noCareerRequestFoundTitle,
            color: context.colorPalette.neutral.grey9,
            style: context.typography.headlineSmall,
            softWrap: true,
            textAlign: TextAlign.center,
          ),
          const DSVerticalSpacerWidget(2),
          DSTextWidget(
            context.localizations.noCareerRequestFoundDescription,
            color: context.colorPalette.neutral.grey7,
            style: context.typography.bodyLarge,
            softWrap: true,
            textAlign: TextAlign.center,
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }

  List<Widget> _getDesktopSlivers(
    BuildContext context,
    Map<String, List<CareerEntity>> careerMap,
  ) {
    final widgets = <Widget>[];
    careerMap.forEach((key, value) {
      widgets.add(
        DateHeaderWidget(leftLabel: key, applicationCount: value.length),
      );
      widgets.add(const SliverToBoxAdapter(child: DSVerticalSpacerWidget(2)));
      widgets.add(
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(
              left: _getPadding(context),
              right: _getPadding(context),
              bottom: context.space(factor: 2),
            ),
            child: DSMasonStaggeredGridWidget(
              crossAxisCount: 2,
              itemCount: value.length,
              mainAxisSpacing: context.space(),
              crossAxisSpacing: context.space(),
              itemBuilder: (_, index) => CareerCardWidget(value[index]),
            ),
          ),
        ),
      );
    });
    return widgets;
  }

  List<Widget> _getMobileSlivers(
    BuildContext context,
    Map<String, List<CareerEntity>> careerMap,
  ) {
    final widgets = <Widget>[];
    careerMap.forEach((key, value) {
      widgets.add(
        DateHeaderWidget(leftLabel: key, applicationCount: value.length),
      );
      widgets.add(const SliverToBoxAdapter(child: DSVerticalSpacerWidget(2)));
      widgets.add(
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (_, index) {
              return Padding(
                padding: EdgeInsets.only(
                  left: _getPadding(context),
                  right: _getPadding(context),
                  bottom: context.space(factor: 2),
                ),
                child: CareerCardWidget(value[index]),
              );
            },
            childCount: value.length,
          ),
        ),
      );
    });
    return widgets;
  }

  double _getPadding(BuildContext context) {
    switch (context.deviceWidth) {
      case DSDeviceWidthResolution.xs:
        return context.space(factor: 4);
      case DSDeviceWidthResolution.s:
      case DSDeviceWidthResolution.m:
      case DSDeviceWidthResolution.l:
      case DSDeviceWidthResolution.xl:
        return context.width * 0.1;
    }
  }
}
