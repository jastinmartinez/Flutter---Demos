import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:socketio_app/Controller/socket_client_controller.dart';

import 'package:socketio_app/Views/screens/chat_screen.dart';
import 'package:socketio_app/Views/widgets/name_form.dart';
import 'package:socketio_app/helper/hex_color.dart';

class HomePageScreen extends StatefulWidget {
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final _socketClientController = Get.put(SocketClientController());
  @override
  void dispose() {
    _socketClientController.disconnectFromChat();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('8ac4d0'),
        title: Obx(
          () => Text('Users (${_socketClientController.numberOfUser})'),
        ),
      ),
      body: GestureDetector(
        child: Obx(
          () {
            if (_socketClientController.socketStatus.value ==
                SocketStatus.Connecting)
              return Center(
                child: CircularProgressIndicator(),
              );
            if (_socketClientController.socketStatus.value ==
                SocketStatus.Connected)
              return NameForm();
            else if (_socketClientController.socketStatus.value ==
                SocketStatus.Joined)
              return ChatScreen();
            else
              return Center(
                child: Text('Disconected'),
              );
          },
        ),
      ),
    );
  }
}
