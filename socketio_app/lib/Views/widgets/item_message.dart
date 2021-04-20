import 'package:flutter/material.dart';

import 'package:socketio_app/Model/chat_message.dart';
import 'package:socketio_app/helper/hex_color.dart';

class ItemMessage extends StatelessWidget {
  final ChatMessage message;

  const ItemMessage({
    Key key,
    this.message,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: message.userSender ? WrapAlignment.end : WrapAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: 300,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          margin: EdgeInsets.only(
            bottom: 10,
          ),
          child: Container(
            color: message.userSender ? HexColor('fbeeac') : HexColor('8ac4d0'),
            child: ListTile(
              title: Text(
                message.useName,
                style: TextStyle(color: HexColor('0f1123')),
              ),
              subtitle: Text(
                message.userMessage,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
