import 'package:flutter/material.dart';

import 'app_color.dart';

class AppMessages {
  static void saveMessage(
    BuildContext context,
    String messsage,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          messsage,
          style: TextStyle(
            color: AppColor.kWhite,
          ),
        ),
        duration: Duration(milliseconds: 500),
        backgroundColor: AppColor.kBlue,
      ),
    );
  }
}
