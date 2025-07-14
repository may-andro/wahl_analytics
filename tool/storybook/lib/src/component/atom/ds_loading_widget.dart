import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:storybook/src/model/option.dart';
import 'package:storybook/src/widget/base_scaffold_widget.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Loading Widget', type: LoadingWidget)
LoadingWidget loadingWidget(BuildContext context) {
  return const LoadingWidget();
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldWidget(
      title: 'DSLoadingWidget',
      child: Center(
        child: DSLoadingWidget(
          size: context.knobs
              .list<Option<double>>(
                label: 'Size',
                options: <Option<double>>[
                  Option(16, '16 pixel'),
                  Option(32, '32 pixel'),
                  Option(48, '48 pixel'),
                  Option(64, '64 pixel'),
                ],
                labelBuilder: (option) => option.label,
              )
              .value,
        ),
      ),
    );
  }
}
