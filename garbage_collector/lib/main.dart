import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garbage_collector/view/screen/home_screen.dart';

import 'logic/bloc/authentication/authentication_bloc.dart';
import 'logic/bloc/authentication/authentication_state.dart';
import 'utils/app_color.dart';
import 'view/routes/app_route.dart';
import 'view/screen/authentication/authentication_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp(
    appRouter: AppRouter(),
  ));
}

class MyApp extends StatefulWidget {
  final AppRouter appRouter;

  const MyApp({
    Key key,
    this.appRouter,
  }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationBloc(),
      child: MaterialApp(
        title: 'Garbage Collector',
        theme: ThemeData(
          primaryColor: AppColor.kBlue,
          accentColor: AppColor.kYellow,
        ),
        onGenerateRoute: widget.appRouter.onGnerateRoute,
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationAuthenticated) {
              return HomeScreen();
            }
            return AuthenticationScreen();
          },
        ),
      ),
    );
  }
}
