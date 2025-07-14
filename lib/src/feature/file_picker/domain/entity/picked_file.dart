import 'package:flutter/foundation.dart';

class PickedFile {
  PickedFile({required this.name, required this.bytes});

  final String name;
  final Uint8List bytes;
}
