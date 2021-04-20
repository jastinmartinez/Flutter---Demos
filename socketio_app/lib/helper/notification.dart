import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:socketio_app/helper/hex_color.dart';

class Notification {
  static showUserLeft(String text) {
    showSimpleNotification(Text(text), background: HexColor('e94560'));
  }
}
