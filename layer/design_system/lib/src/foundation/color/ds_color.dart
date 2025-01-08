import 'package:flutter/material.dart';

final class DSColor {
  const DSColor(this._colorValue);

  final int _colorValue;

  Color get color => Color(_colorValue);
}
