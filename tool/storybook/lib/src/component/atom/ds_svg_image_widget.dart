import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:storybook/src/model/option.dart';
import 'package:storybook/src/widget/base_scaffold_widget.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Svg Image Widget', type: SvgImageWidget)
SvgImageWidget svgImageWidget(BuildContext context) {
  return const SvgImageWidget();
}

class SvgImageWidget extends StatelessWidget {
  const SvgImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldWidget(
      title: 'DSSvgImageWidget',
      child: Center(
        child: DSSvgImageWidget(
          assetImage: context.knobs
              .list<Option<DSSvgAssetImage>>(
                label: 'Asset Image',
                options: <Option<DSSvgAssetImage>>[
                  Option(DSSvgAssetImage.logo, 'Logo'),
                  Option(DSSvgAssetImage.logoDark, 'Logo Dark'),
                  Option(DSSvgAssetImage.logoLight, 'Logo Light'),
                ],
                labelBuilder: (option) => option.label,
              )
              .value,
          height: context.knobs
              .list<Option<double?>>(
                label: 'Height',
                options: <Option<double?>>[
                  Option(null, 'Not Defined'),
                  Option(context.height * 0.25, '25% Screen Height'),
                  Option(context.height * 0.5, '50% Screen Height'),
                  Option(context.height, '100% Screen Height'),
                ],
                labelBuilder: (option) => option.label,
              )
              .value,
          width: context.knobs
              .list<Option<double?>>(
                label: 'Width',
                options: <Option<double?>>[
                  Option(null, 'Not Defined'),
                  Option(context.width * 0.25, '25% Screen Width'),
                  Option(context.width * 0.5, '50% Screen Width'),
                  Option(context.width, '100% Screen Width'),
                ],
                labelBuilder: (option) => option.label,
              )
              .value,
          fit: context.knobs
              .list<Option<BoxFit>>(
                label: 'Box Fit',
                options: <Option<BoxFit>>[
                  Option(BoxFit.contain, 'Contain'),
                  Option(BoxFit.none, 'None'),
                  Option(BoxFit.fill, 'Fill'),
                  Option(BoxFit.cover, 'Cover'),
                  Option(BoxFit.scaleDown, 'ScaleDown'),
                  Option(BoxFit.fitHeight, 'FitHeight'),
                  Option(BoxFit.fitWidth, 'FitWidth'),
                ],
                labelBuilder: (option) => option.label,
              )
              .value,
        ),
      ),
    );
  }
}
