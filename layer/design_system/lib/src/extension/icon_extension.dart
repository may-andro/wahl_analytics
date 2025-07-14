import 'package:collection/collection.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

extension IconExtension on String {
  IconData get customIconData {
    final iconData = DSIcons.all.firstWhereOrNull(
      (iconData) => iconData.codePoint == int.parse(this),
    );

    return iconData ?? Icons.question_mark;
  }
}
