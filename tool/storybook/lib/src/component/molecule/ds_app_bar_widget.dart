import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:storybook/src/widget/base_scaffold_widget.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'App Bar Widget',
  type: AppBarWidget,
)
AppBarWidget appBarWidget(BuildContext context) {
  return const AppBarWidget();
}

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldWidget(
      title: 'DSAppBarWidget',
      child: Scaffold(
        appBar: DSAppBarWidget(
          height: DSAppBarWidget.getHeight(context),
          onBackClicked: () {
            final snackBar = SnackBar(
              content: DSTextWidget(
                'Provide this behaviour for your app bar',
                color: context.colorPalette.neutral.grey9,
                style: context.typography.bodyMedium,
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
        ),
      ),
    );
  }
}
