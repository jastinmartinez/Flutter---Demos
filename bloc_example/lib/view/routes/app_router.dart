import 'package:bloc_example/view/screens/first_screen.dart';
import 'package:bloc_example/view/screens/second_screen.dart';
import 'package:bloc_example/view/screens/third_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route onGnerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => FirstScreen(
            title: 'First Page',
            color: Colors.blue,
          ),
        );
        break;
      case '/second':
        return MaterialPageRoute(
          builder: (_) => SecondScreen(
            title: 'Second Page',
            color: Colors.red,
          ),
        );
        break;
      case '/third':
        return MaterialPageRoute(
          builder: (_) => ThirdScreen(
            title: 'Third Page',
            color: Colors.green,
          ),
        );
        break;
      default:
        return null;
    }
  }
}
