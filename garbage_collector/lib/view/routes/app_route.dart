import 'package:flutter/material.dart';
import 'package:garbage_collector/view/screen/maps/maps_screen.dart';
import 'package:garbage_collector/view/screen/maps/permision_request_screen.dart';
import 'package:garbage_collector/view/screen/maps/verify_permision_screen.dart';

import '../screen/authentication/authentication_screen.dart';
import '../screen/home_screen.dart';
import '../screen/truck/truck_screen.dart';

class AppRouter {
  static const String homeScreen = '/';
  static const String authenticationScreen = '/authenticationScreen';
  static const String truckScreen = '/truckScreen';
  static const String permissionRequestScreen = '/permissionRequestScreen';
  static const String verifyPermissionScreen = '/verifyPermissionScreen';
  static const String mapScreens = '/mapScreens';

  Route onGnerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case homeScreen:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );
        break;
      case authenticationScreen:
        return MaterialPageRoute(
          builder: (_) => AuthenticationScreen(),
        );
        break;
      case truckScreen:
        return MaterialPageRoute(
          builder: (_) => TruckScreen(),
        );
        break;
      case permissionRequestScreen:
        return MaterialPageRoute(
          builder: (_) => PermissionRequestScreen(),
        );
        break;
      case verifyPermissionScreen:
        return MaterialPageRoute(
          builder: (_) => VerifyPermissionScreen(
            key: UniqueKey(),
          ),
        );
        break;
      case mapScreens:
        return MaterialPageRoute(
          builder: (_) => MapsScreen(
            key: UniqueKey(),
          ),
        );
        break;
      default:
        return null;
    }
  }
}
