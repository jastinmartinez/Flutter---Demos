import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garbage_collector/view/routes/app_route.dart';

import '../../logic/bloc/authentication/authentication_bloc.dart';
import '../../logic/bloc/authentication/authentication_event.dart';
import '../../utils/app_color.dart';
import '../widgets/app_drawer.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.notification_important,
              color: AppColor.kYellow,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.popUntil(
                context,
                ModalRoute.withName(
                  AppRouter.homeScreen,
                ),
              );
              BlocProvider.of<AuthenticationBloc>(context).add(
                AuthenticationLoggedOut(),
              );
            },
          ),
        ],
      ),
    );
  }
}
