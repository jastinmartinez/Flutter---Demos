import 'package:flutter/material.dart';
import 'package:garbage_collector/utils/app_color.dart';
import 'package:garbage_collector/view/routes/app_route.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionRequestScreen extends StatefulWidget {
  @override
  _PermissionRequestState createState() => _PermissionRequestState();
}

class _PermissionRequestState extends State<PermissionRequestScreen> {
  Future<void> _requestPermission() async {
    final permissionResult = await Permission.locationWhenInUse.request();
    if (permissionResult.isGranted) {
      Navigator.pushReplacementNamed(context, AppRouter.mapScreens);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "PERMISO REQUERIDO",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                "Acceso a la ubicacion para poder gestionar y monitoriar el proceso de ruta",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  AppColor.kBlue,
                ),
              ),
              onPressed: _requestPermission,
              child: Text(
                'PERMITIR',
                style: TextStyle(
                  color: AppColor.kWhite,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
