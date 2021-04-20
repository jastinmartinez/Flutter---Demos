import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:socketio_app/Controller/socket_client_controller.dart';

import 'package:socketio_app/helper/hex_color.dart';

class NameForm extends StatefulWidget {
  @override
  _NameFormState createState() => _NameFormState();
}

class _NameFormState extends State<NameForm> {
  final _formKey = GlobalKey<FormState>();
  final _nickeNameController = TextEditingController();
  final _socketClientController = Get.find<SocketClientController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'What\'s your nickname?',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Form(
              key: _formKey,
              child: CupertinoTextField(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                controller: _nickeNameController,
                placeholder: 'Nick name...',
                textAlign: TextAlign.center,
                keyboardType: TextInputType.name,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CupertinoButton(
              borderRadius: BorderRadius.circular(30),
              color: HexColor('f4d160'),
              child: Text('Join to chat'),
              onPressed: () {
                if (_nickeNameController.text.trim().length > 0) {
                  _socketClientController.joinChat(
                    _nickeNameController.text,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
