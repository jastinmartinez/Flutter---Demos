import 'package:flutter/foundation.dart';

class ChatMessage {
  final String useName, userMessage;
  final bool userSender;

  ChatMessage({
    @required this.useName,
    @required this.userMessage,
    @required this.userSender,
  });
}
