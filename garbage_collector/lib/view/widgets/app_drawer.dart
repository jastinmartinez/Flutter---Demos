import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/svg.dart';
import 'package:garbage_collector/logic/bloc/authentication/authentication_bloc.dart';
import 'package:garbage_collector/logic/bloc/authentication/authentication_state.dart';

import 'package:garbage_collector/view/routes/app_route.dart';

import '../../utils/app_color.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                return ListTile(
                  title: Text(
                    'Hola! ${state is AuthenticationAuthenticated ? state.user.email.substring(0, state.user.email.indexOf("@")) : ''}',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Text(
                    state is AuthenticationAuthenticated
                        ? state.user.email
                        : '',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {},
                  trailing: SvgPicture.asset(
                    'assets/images/trashcan.svg',
                    height: 50,
                  ),
                );
              },
            ),
            decoration: BoxDecoration(
              color: AppColor.kBlue,
            ),
          ),
          ExpansionTile(
            trailing: Icon(Icons.work),
            title: Text('Operaciones'),
            children: [
              ListTile(
                title: Text('Camiones'),
                onTap: () {
                  Navigator.of(context).pushNamed(
                    AppRouter.truckScreen,
                  );
                },
                trailing: Icon(Icons.car_rental),
              ),
              ListTile(
                title: Text('Rutas'),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRouter.verifyPermissionScreen,
                  );
                },
                trailing: Icon(Icons.map),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
