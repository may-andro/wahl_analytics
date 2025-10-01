import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:storybook/src/model/option.dart';
import 'package:storybook/src/widget/base_scaffold_widget.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'View State Builder Widget',
  type: ViewStateBuilderWidget,
)
ViewStateBuilderWidget viewStateBuilderWidget(BuildContext context) {
  return const ViewStateBuilderWidget();
}

class ViewStateBuilderWidget extends StatelessWidget {
  const ViewStateBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldWidget(
      title: 'DSViewStateBuilderWidget',
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(context.space(factor: 2)),
          child: SizedBox(
            height: context.height * 0.5,
            child: DsCardWidget(
              backgroundColor: context.colorPalette.background.primary,
              elevation: context.dimen.elevationLevel3,
              radius: context.dimen.radiusLevel3,
              child: Padding(
                padding: EdgeInsets.all(context.space(factor: 4)),
                child: Center(
                  child: DSViewStateBuilderWidget(
                    state: context.knobs.object
                        .dropdown<Option<DSViewState>>(
                          label: 'View State',
                          options: <Option<DSViewState>>[
                            Option(DSViewState.idle, 'Idle'),
                            Option(DSViewState.error, 'Error'),
                            Option(DSViewState.loading, 'Loading'),
                          ],
                          labelBuilder: (option) => option.label,
                        )
                        .value,
                    loadingBuilder: (_) {
                      return DSLoadingWidget(size: context.space(factor: 5));
                    },
                    errorBuilder: context.knobs.object
                        .dropdown<Option<WidgetBuilder?>>(
                          label: 'Error Widget',
                          options: [
                            Option(null, 'Default'),
                            Option(
                              (_) => DSTextWidget(
                                'Error View State',
                                color: context.colorPalette.semantic.error,
                                style: context.typography.headlineMedium,
                              ),
                              'Custom',
                            ),
                          ],
                          labelBuilder: (option) => option.label,
                        )
                        .value,
                    builder: (_) {
                      return DSTextWidget(
                        'Success View State',
                        color: context.colorPalette.semantic.success,
                        style: context.typography.headlineMedium,
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
