import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/bloc/truck/truck_bloc.dart';
import '../../../utils/app_color.dart';
import 'widgets/truck_form.dart';

class TruckScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kBlue,
      body: SafeArea(
        maintainBottomViewPadding: false,
        child: BlocProvider(
          create: (context) => TruckBloc(),
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.all(30),
                      child: TruckForm(),
                      margin: EdgeInsets.only(
                        top: 30,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.kWhite,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
