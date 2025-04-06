import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:storybook/src/widget/base_scaffold_widget.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Icon Title Tile Widget',
  type: DSIconTitleTileWidget,
)
Widget build(BuildContext context) {
  final colorMap = context.colorMap;
  final colors = colorMap.keys.toList();

  final textStyleMap = context.textStyleMap;
  final textStyles = textStyleMap.keys.toList();

  final iconMap = {Icons.add: 'Add', Icons.remove: 'Remove'};

  return BaseScaffoldWidget(
    title: 'DSIconTitleTileWidget',
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: DSIconTitleTileWidget(
          text: context.knobs.string(
            label: 'Text',
            initialValue:
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. '
                'Lorem Ipsum has been the industry standard dummy text ever since the 1500s, '
                'when an unknown printer took a galley of type and scrambled it to make a type specimen book. ',
          ),
          textColor: context.knobs.list(
            label: 'Text Colors',
            options: colors,
            labelBuilder: (color) => colorMap[color] ?? 'Not found',
            initialOption: colors[12],
          ),
          style: context.knobs.list(
            label: 'Style',
            options: textStyles,
            labelBuilder: (style) => textStyleMap[style] ?? 'Not found',
          ),
          icon: context.knobs.list(
            label: 'Icon',
            options: iconMap.keys.toList(),
            labelBuilder: (icon) => iconMap[icon] ?? 'Not found',
          ),
          iconSize: context.knobs.doubleOrNull.slider(
            label: 'Icon Size',
            min: 0,
            max: 100,
          ),
        ),
      ),
    ),
  );
}
