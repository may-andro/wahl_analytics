import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:storybook/src/model/option.dart';
import 'package:storybook/src/widget/base_scaffold_widget.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Carousal Widget', type: CarousalWidget)
CarousalWidget carousalWidget(BuildContext context) {
  return const CarousalWidget();
}

class CarousalWidget extends StatelessWidget {
  const CarousalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldWidget(
      title: 'DSCarousalWidget',
      child: Center(
        child: DSCarousalWidget(
          height: context.height * 0.5,
          viewportFraction: context.knobs
              .list<Option<double>>(
                label: 'Viewport Fraction',
                options: [
                  Option(1.0, '1.0'),
                  Option(0.75, '0.75'),
                  Option(0.25, '0.25'),
                ],
                labelBuilder: (option) => option.label,
              )
              .value,
          enableInfiniteScroll: context.knobs
              .list<Option<bool>>(
                label: 'Enable Infinite Scroll ?',
                options: [Option(false, 'No'), Option(true, 'Yes')],
                labelBuilder: (option) => option.label,
              )
              .value,
          autoPlay: context.knobs
              .list<Option<bool>>(
                label: 'Auto Play ?',
                options: [Option(false, 'No'), Option(true, 'Yes')],
                labelBuilder: (option) => option.label,
              )
              .value,
          onPageChanged: (index, reason) {
            final snackBar = SnackBar(
              content: DSTextWidget(
                'Index: $index, Reason: $reason',
                color: context.colorPalette.neutral.grey9,
                style: context.typography.bodyMedium,
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
          scrollDirection: context.knobs
              .list<Option<Axis>>(
                label: 'Scroll Direction',
                options: [
                  Option(Axis.horizontal, 'Axis Horizontal'),
                  Option(Axis.vertical, 'Axis Vertical'),
                ],
                labelBuilder: (option) => option.label,
              )
              .value,
          scrollPhysics: context.knobs
              .list<Option<ScrollPhysics?>>(
                label: 'Scroll Physics',
                options: [
                  Option(null, 'None [Default]'),
                  Option(
                    const NeverScrollableScrollPhysics(),
                    'NeverScrollableScrollPhysics',
                  ),
                  Option(
                    const AlwaysScrollableScrollPhysics(),
                    'AlwaysScrollableScrollPhysics',
                  ),
                  Option(
                    const ClampingScrollPhysics(),
                    'ClampingScrollPhysics',
                  ),
                  Option(
                    const BouncingScrollPhysics(),
                    'BouncingScrollPhysics',
                  ),
                  Option(
                    const RangeMaintainingScrollPhysics(),
                    'RangeMaintainingScrollPhysics',
                  ),
                ],
                labelBuilder: (option) => option.label,
              )
              .value,
          children: [
            DsCardWidget(
              backgroundColor: context.colorPalette.semantic.success,
              elevation: context.dimen.elevationLevel3,
              radius: context.dimen.radiusLevel3,
              margin: EdgeInsets.all(context.space(factor: 2)),
              child: Padding(
                padding: EdgeInsets.all(context.space(factor: 2)),
                child: Center(
                  child: DSTextWidget(
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                    color: context.colorPalette.semantic.onSuccess,
                    style: context.typography.headlineMedium,
                  ),
                ),
              ),
            ),
            DsCardWidget(
              backgroundColor: context.colorPalette.semantic.error,
              elevation: context.dimen.elevationLevel3,
              radius: context.dimen.radiusLevel3,
              margin: EdgeInsets.all(context.space(factor: 2)),
              child: Padding(
                padding: EdgeInsets.all(context.space(factor: 2)),
                child: Center(
                  child: DSTextWidget(
                    "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                    color: context.colorPalette.semantic.onError,
                    style: context.typography.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            DsCardWidget(
              backgroundColor: context.colorPalette.semantic.warning,
              elevation: context.dimen.elevationLevel3,
              radius: context.dimen.radiusLevel3,
              margin: EdgeInsets.all(context.space(factor: 2)),
              child: Padding(
                padding: EdgeInsets.all(context.space(factor: 2)),
                child: Center(
                  child: DSTextWidget(
                    'It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
                    color: context.colorPalette.semantic.onWarning,
                    style: context.typography.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            DsCardWidget(
              backgroundColor: context.colorPalette.semantic.info,
              elevation: context.dimen.elevationLevel3,
              radius: context.dimen.radiusLevel3,
              margin: EdgeInsets.all(context.space(factor: 2)),
              child: Padding(
                padding: EdgeInsets.all(context.space(factor: 2)),
                child: Center(
                  child: DSTextWidget(
                    'It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                    color: context.colorPalette.semantic.onInfo,
                    style: context.typography.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
