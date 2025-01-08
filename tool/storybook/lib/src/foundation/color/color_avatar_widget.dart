import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:storybook/src/widget/base_scaffold_widget.dart';

class ColorAvatar {
  ColorAvatar(this.color, this.title);

  final Color color;
  final String title;
}

class ColorAvatarBuilderWidget extends StatelessWidget {
  const ColorAvatarBuilderWidget(
    this.colorAvatars, {
    required this.title,
    super.key,
  });

  final String title;
  final List<ColorAvatar> colorAvatars;

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldWidget(
      title: title,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return _ColorAvatarWidget(colorAvatars[index]);
        },
        shrinkWrap: true,
        itemCount: colorAvatars.length,
      ),
    );
  }
}

class _ColorAvatarWidget extends StatelessWidget {
  const _ColorAvatarWidget(this.colorAvatar);

  final ColorAvatar colorAvatar;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: context.space(factor: 0.5)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: colorAvatar.color,
        ),
        title: Text(
          colorAvatar.title,
          style: context.typography.bodyLarge.textStyle.copyWith(
            color: context.colorPalette.neutral.grey9.color,
          ),
        ),
        subtitle: Text(
          colorAvatar.color.hex,
          style: context.typography.bodyMedium.textStyle.copyWith(
            color: context.colorPalette.neutral.grey7.color,
          ),
        ),
      ),
    );
  }
}

extension _ColorExtension on Color {
  String get hex {
    final red = (r * 255).toInt().toRadixString(16).padLeft(2, '0');
    final green = (g * 255).toInt().toRadixString(16).padLeft(2, '0');
    final blue = (b * 255).toInt().toRadixString(16).padLeft(2, '0');
    final alpha = (a * 255).toInt().toRadixString(16).padLeft(2, '0');

    return '$alpha$red$green$blue';
  }
}
