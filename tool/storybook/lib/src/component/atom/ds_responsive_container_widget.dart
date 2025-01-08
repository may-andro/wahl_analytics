import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:storybook/src/widget/base_scaffold_widget.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Responsive Container Widget',
  type: ResponsiveContainerWidget,
)
ResponsiveContainerWidget responsiveContainerWidget(BuildContext context) {
  return const ResponsiveContainerWidget();
}

class ResponsiveContainerWidget extends StatelessWidget {
  const ResponsiveContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldWidget(
      title: 'DSResponsiveContainerWidget',
      child: Center(
        child: DSResponsiveContainerWidget(
          mobileBuilder: (_) {
            return DSTextWidget(
              'This is mobile version of the view',
              color: context.colorPalette.brand.primary,
              style: context.typography.bodyLarge,
            );
          },
          tabletBuilder: (_) {
            return DSTextWidget(
              'This is tablet version of the view',
              color: context.colorPalette.brand.primary,
              style: context.typography.bodyLarge,
            );
          },
          desktopBuilder: (_) {
            return DSTextWidget(
              'This is desktop version of the view',
              color: context.colorPalette.brand.primary,
              style: context.typography.bodyLarge,
            );
          },
        ),
      ),
    );
  }
}
