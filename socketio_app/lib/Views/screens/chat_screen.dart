import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:socketio_app/Controller/socket_client_controller.dart';
import 'package:socketio_app/Views/widgets/item_message.dart';
import 'package:socketio_app/helper/hex_color.dart';

class ChatScreen extends StatefulWidget {
  final VoidCallback onSent;

  const ChatScreen({Key key, this.onSent}) : super(key: key);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _socketController = Get.put(SocketClientController());
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();

  var _chatSubcription;
  var _valueNotfier = ValueNotifier(0);
  var _isScrollEnd = false;

  void _scrollDownToEnd() {
    Future.delayed(
      Duration(milliseconds: 200),
      () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 500),
          curve: Curves.linear,
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _chatSubcription = _socketController.chatMessage.listen(
      (_) {
        if (_.length > 0 && !_.last.userSender) {
          if (_isScrollEnd) {
            _scrollDownToEnd();
          } else {
            _valueNotfier.value++;
          }
        }
      },
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _socketController.dispose();
    _chatSubcription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Obx(
                      () => NotificationListener(
                        onNotification: (n) {
                          if (n is ScrollEndNotification) {
                            _isScrollEnd = _scrollController.offset >=
                                _scrollController.position.maxScrollExtent;
                          }
                          return false;
                        },
                        child: ListView.builder(
                          controller: _scrollController,
                          itemBuilder: (_, index) => ItemMessage(
                            message: _socketController.chatMessage[index],
                          ),
                          itemCount: _socketController.chatMessage.length,
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => Text(
                      _socketController.typingUser != null
                          ? '${_socketController.typingUser} is typing'
                          : '',
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: HexColor('fbeeac'),
                      borderRadius: BorderRadius.circular(
                        30,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 7,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: CupertinoTextField(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                            controller: _messageController,
                            placeholder: 'Type..',
                            onChanged: (e) =>
                                _socketController.onInputChange(e),
                          ),
                        ),
                        CupertinoButton(
                          color: HexColor('e94560'),
                          padding: EdgeInsets.all(5),
                          borderRadius: BorderRadius.circular(30),
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            if (_socketController.sendMessage()) {
                              _messageController.clear();
                              _scrollDownToEnd();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ValueListenableBuilder(
              valueListenable: _valueNotfier,
              builder: (context, value, child) => value > 0
                  ? Positioned(
                      right: 10,
                      bottom: 120,
                      child: FloatingActionButton(
                        backgroundColor: HexColor('e94560'),
                        onPressed: () {
                          _valueNotfier.value = 0;
                          _scrollDownToEnd();
                        },
                        child: Text('$value'),
                      ),
                    )
                  : Container(),
            )
          ],
        ),
      ),
    );
  }
}
