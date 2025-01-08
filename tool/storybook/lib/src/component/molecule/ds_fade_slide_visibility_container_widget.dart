import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:storybook/src/widget/base_scaffold_widget.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

String _sampleText =
    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. '
    "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. "
    'It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. '
    'It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.';

@widgetbook.UseCase(
  name: 'Fade Slide Visibility Container Widget',
  type: FadeSlideVisibilityContainerWidget,
)
FadeSlideVisibilityContainerWidget horizontalDividerWidget(
  BuildContext context,
) {
  return const FadeSlideVisibilityContainerWidget();
}

class FadeSlideVisibilityContainerWidget extends StatelessWidget {
  const FadeSlideVisibilityContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldWidget(
      title: 'DSFadeSlideVisibilityContainerWidget',
      child: Center(
        child: DSFadeSlideVisibilityContainerWidget(
          uniqueId: 'uniqueId',
          child: DsCardWidget(
            margin: EdgeInsets.all(context.space(factor: 2)),
            backgroundColor: context.colorPalette.brand.primary,
            elevation: context.dimen.elevationLevel3,
            radius: context.dimen.radiusLevel3,
            child: Padding(
              padding: EdgeInsets.all(context.space(factor: 2)),
              child: DSTextWidget(
                _sampleText,
                color: context.colorPalette.brand.onPrimary,
                style: context.typography.headlineMedium,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
