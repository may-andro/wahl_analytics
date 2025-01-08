import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:storybook/src/widget/base_scaffold_widget.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Visibility Detector Widget',
  type: VisibilityDetectorWidget,
)
VisibilityDetectorWidget visibilityDetectorWidget(BuildContext context) {
  return const VisibilityDetectorWidget();
}

class VisibilityDetectorWidget extends StatefulWidget {
  const VisibilityDetectorWidget({super.key});

  @override
  State<VisibilityDetectorWidget> createState() =>
      _VisibilityDetectorWidgetState();
}

class _VisibilityDetectorWidgetState extends State<VisibilityDetectorWidget> {
  double? visibility;

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldWidget(
      title: 'DSVisibilityDetectorWidget',
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.maxFinite,
              height: context.height * 0.25,
              color: context.colorPalette.semantic.error.color,
              child: Center(
                child: DSTextWidget(
                  'Scroll down to see the Visibility Detector',
                  color: context.colorPalette.neutral.grey9,
                  style: context.typography.titleLarge,
                ),
              ),
            ),
            Container(
              height: context.height * 0.25,
              color: context.colorPalette.semantic.info.color,
            ),
            Container(
              height: context.height * 0.25,
              color: context.colorPalette.semantic.warning.color,
            ),
            Container(
              height: context.height * 0.25,
              color: context.colorPalette.semantic.success.color,
            ),
            DSVisibilityDetectorWidget(
              onVisibilityChanged: (visibilityInfo) {
                setState(() => visibility = visibilityInfo);
              },
              key: UniqueKey(),
              child: Container(
                width: double.maxFinite,
                height: context.height * 0.25,
                color: context.colorPalette.brand.primary.color,
                child: DSTextWidget(
                  'Visibility: $visibility',
                  color: context.colorPalette.neutral.grey9,
                  style: context.typography.headlineMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
