import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:storybook/src/model/option.dart';
import 'package:storybook/src/widget/base_scaffold_widget.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Shimmer Loading Widget', type: ShimmerLoadingWidget)
ShimmerLoadingWidget shimmerLoadingWidget(BuildContext context) {
  return const ShimmerLoadingWidget();
}

class ShimmerLoadingWidget extends StatelessWidget {
  const ShimmerLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldWidget(
      title: 'DSShimmerLoadingWidget',
      child: Center(
        child: DSShimmerLoadingWidget(
          height: context.knobs.object
              .dropdown<Option<double>>(
                label: 'Height',
                options: <Option<double>>[
                  Option(context.height * 0.25, '25% Screen Height'),
                  Option(context.height * 0.5, '50% Screen Height'),
                  Option(context.height, '100% Screen Height'),
                ],
                labelBuilder: (option) => option.label,
              )
              .value,
          width: context.knobs.object
              .dropdown<Option<double>>(
                label: 'Width',
                options: <Option<double>>[
                  Option(context.width * 0.25, '25% Screen Width'),
                  Option(context.width * 0.5, '50% Screen Width'),
                  Option(context.width, '100% Screen Width'),
                ],
                labelBuilder: (option) => option.label,
              )
              .value,
        ),
      ),
    );
  }
}
