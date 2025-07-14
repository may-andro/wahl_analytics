import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:storybook/src/model/option.dart';
import 'package:storybook/src/widget/base_scaffold_widget.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Error Card Widget', type: ErrorCardWidget)
ErrorCardWidget errorCardWidget(BuildContext context) {
  return const ErrorCardWidget();
}

class ErrorCardWidget extends StatelessWidget {
  const ErrorCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldWidget(
      title: 'DSErrorCardWidget',
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(context.space(factor: 2)),
          child: DSErrorCardWidget(
            message: 'Something went wrong, please try again later',
            onRetryClicked: context.knobs
                .list<Option<void Function()?>>(
                  label: 'On Retry Clicked',
                  options: [
                    Option(null, 'Default [Non Clickable]'),
                    Option(() {
                      final snackBar = SnackBar(
                        content: DSTextWidget(
                          'On retry clicked',
                          color: context.colorPalette.neutral.grey9,
                          style: context.typography.bodyMedium,
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }, 'With Action'),
                  ],
                  labelBuilder: (option) => option.label,
                )
                .value,
          ),
        ),
      ),
    );
  }
}
