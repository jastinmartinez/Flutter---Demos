import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/services.dart';

Future<Uint8List> loadAssetAsAByte(
  String path, {
  int height = 50,
  int width = 50,
}) async {
  var _data = await rootBundle.load(path);
  final _codec = await instantiateImageCodec(_data.buffer.asUint8List(),
      targetHeight: height, targetWidth: width);
  final _frame = await _codec.getNextFrame();
  _data = await _frame.image.toByteData(format: ImageByteFormat.png);
  return _data.buffer.asUint8List();
}
