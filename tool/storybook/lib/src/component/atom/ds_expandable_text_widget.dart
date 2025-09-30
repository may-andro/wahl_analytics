import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:storybook/src/widget/base_scaffold_widget.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'ExpandableTextWidget', type: DSExpandableTextWidget)
Widget build(BuildContext context) {
  final colorMap = context.colorMap;
  final colors = colorMap.keys.toList();

  final textStyleMap = context.textStyleMap;
  final textStyles = textStyleMap.keys.toList();

  return BaseScaffoldWidget(
    title: 'DSIconTitleTileWidget',
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: DSExpandableTextWidget(
        context.knobs.string(
          label: 'Text',
          initialValue:
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. '
              'Lorem Ipsum has been the industry standard dummy text ever since the 1500s, '
              'when an unknown printer took a galley of type and scrambled it to make a type specimen book. ',
        ),
        style: context.knobs.object.dropdown(
          label: 'Style',
          options: textStyles,
          labelBuilder: (style) => textStyleMap[style] ?? 'Not found',
        ),
        textColor: context.knobs.object.dropdown(
          label: 'Text Colors',
          options: colors,
          labelBuilder: (color) => colorMap[color] ?? 'Not found',
        ),
        collapsedTextColor: context.knobs.object.dropdown(
          label: 'Collapsed Text Colors',
          options: colors,
          labelBuilder: (color) => colorMap[color] ?? 'Not found',
        ),
        expandedTextColor: context.knobs.object.dropdown(
          label: 'Expanded Text Colors',
          options: colors,
          labelBuilder: (color) => colorMap[color] ?? 'Not found',
        ),
        trimCollapsedText: context.knobs.string(
          label: 'Show More',
          initialValue: 'Show more',
        ),
        trimExpandedText: context.knobs.string(
          label: 'Show less',
          initialValue: 'Show less',
        ),
        maxLines: context.knobs.int.slider(
          label: 'Max Lines',
          min: 1,
          max: 10,
          initialValue: 2,
        ),
        isExpandable: context.knobs.boolean(label: 'Is Expandable'),
      ),
    ),
  );
}
