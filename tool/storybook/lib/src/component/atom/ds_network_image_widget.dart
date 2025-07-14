import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:storybook/src/model/option.dart';
import 'package:storybook/src/widget/base_scaffold_widget.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Network Image Widget', type: NetworkImageWidget)
NetworkImageWidget networkImageWidget(BuildContext context) {
  return const NetworkImageWidget();
}

class NetworkImageWidget extends StatelessWidget {
  const NetworkImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldWidget(
      title: 'DSNetworkImageWidget',
      child: Center(
        child: ColoredBox(
          color: context.colorPalette.brand.primary.color,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: DSNetworkImageWidget(
              url: 'https://picsum.photos/250?image=8',
              height: context.knobs
                  .list<Option<double>>(
                    label: 'Height',
                    options: <Option<double>>[
                      Option(context.height * 0.25, '25% Screen Height'),
                      Option(context.height * 0.5, '50% Screen Height'),
                      Option(context.height, '100% Screen Height'),
                    ],
                    labelBuilder: (option) => option.label,
                  )
                  .value,
              width: context.knobs
                  .list<Option<double>>(
                    label: 'Width',
                    options: <Option<double>>[
                      Option(context.width * 0.25, '25% Screen Width'),
                      Option(context.width * 0.5, '50% Screen Width'),
                      Option(context.width, '100% Screen Width'),
                    ],
                    labelBuilder: (option) => option.label,
                  )
                  .value,
              fit: context.knobs
                  .list<Option<BoxFit?>>(
                    label: 'Box Fit',
                    options: <Option<BoxFit?>>[
                      Option(BoxFit.none, 'None'),
                      Option(BoxFit.fill, 'Fill'),
                      Option(BoxFit.cover, 'Cover'),
                      Option(BoxFit.contain, 'Contain'),
                      Option(BoxFit.scaleDown, 'ScaleDown'),
                      Option(BoxFit.fitHeight, 'FitHeight'),
                      Option(BoxFit.fitWidth, 'FitWidth'),
                    ],
                    labelBuilder: (option) => option.label,
                  )
                  .value,
              shape: context.knobs
                  .list<Option<BoxShape?>>(
                    label: 'Shape',
                    options: <Option<BoxShape?>>[
                      Option(null, 'None'),
                      Option(BoxShape.circle, 'Circle'),
                      Option(BoxShape.rectangle, 'Rectangle'),
                    ],
                    labelBuilder: (option) => option.label,
                  )
                  .value,
              borderRadius: context.knobs
                  .list<Option<BorderRadius?>>(
                    label: 'Border Radius',
                    options: <Option<BorderRadius?>>[
                      Option(null, 'None'),
                      Option(BorderRadius.circular(8), 'circular: 8 pixel'),
                      Option(
                        const BorderRadius.only(topLeft: Radius.circular(8)),
                        'Top Left: 8 pixel',
                      ),
                      Option(
                        const BorderRadius.only(topRight: Radius.circular(8)),
                        'Top Right: 8 pixel',
                      ),
                      Option(
                        const BorderRadius.only(bottomLeft: Radius.circular(8)),
                        'Bottom Left: 8 pixel',
                      ),
                      Option(
                        const BorderRadius.only(
                          bottomRight: Radius.circular(8),
                        ),
                        'Bottom Right: 8 pixel',
                      ),
                    ],
                    labelBuilder: (option) => option.label,
                  )
                  .value,
              autoSizeImage: context.knobs
                  .list<Option<bool>>(
                    label: 'Auto Size Image',
                    options: <Option<bool>>[
                      Option(false, 'No'),
                      Option(true, 'Yes'),
                    ],
                    labelBuilder: (option) => option.label,
                  )
                  .value,
              loadingWidget: context.knobs
                  .list<Option<Widget?>>(
                    label: 'Loading Widget',
                    options: <Option<Widget?>>[
                      Option(null, 'No loading widget'),
                      Option(
                        DSLoadingWidget(size: context.space(factor: 3)),
                        'Yes',
                      ),
                    ],
                    labelBuilder: (option) => option.label,
                  )
                  .value,
              errorWidget: context.knobs
                  .list<Option<Widget?>>(
                    label: 'Error Widget',
                    options: <Option<Widget?>>[
                      Option(null, 'No error widget'),
                      Option(const DSErrorCardWidget(), 'Yes'),
                    ],
                    labelBuilder: (option) => option.label,
                  )
                  .value,
            ),
          ),
        ),
      ),
    );
  }
}
