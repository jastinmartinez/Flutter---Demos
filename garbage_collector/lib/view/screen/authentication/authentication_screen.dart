import 'package:flutter/material.dart';

import '../../../utils/app_color.dart';
import 'widgets/authentication_form.dart';

class AuthenticationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kBlue,
      body: Center(
        child: AuthenticationForm(),
      ),
    );
  }
}
