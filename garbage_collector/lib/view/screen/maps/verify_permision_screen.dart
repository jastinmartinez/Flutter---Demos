import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:garbage_collector/utils/app_color.dart';
import 'package:garbage_collector/view/routes/app_route.dart';
import 'package:permission_handler/permission_handler.dart';

class VerifyPermissionScreen extends StatefulWidget {
  const VerifyPermissionScreen({Key key}) : super(key: key);
  @override
  _PermissionRequestState createState() => _PermissionRequestState();
}

class _PermissionRequestState extends State<VerifyPermissionScreen>
    with AfterLayoutMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          backgroundColor: AppColor.kBlue,
        ),
      ),
    );
  }

  void _isPermisionGranted() async {
    final hasAccess = await Permission.locationWhenInUse.isGranted;
    if (hasAccess) {
      Navigator.pushReplacementNamed(
        context,
        AppRouter.mapScreens,
      );
    } else {
      Navigator.pushReplacementNamed(
        context,
        AppRouter.permissionRequestScreen,
      );
    }
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _isPermisionGranted();
  }
}
