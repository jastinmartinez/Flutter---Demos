import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/model/truck.dart';
import '../../../../logic/bloc/truck/truck_bloc.dart';
import '../../../../logic/bloc/truck/truck_event.dart';
import '../../../../logic/bloc/truck/truck_state.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/app_messages.dart';
import '../../../../utils/app_responsive.dart';
import '../../../widgets/base_input_form_field.dart';

class TruckForm extends StatefulWidget {
  @override
  _TruckFormState createState() => _TruckFormState();
}

class _TruckFormState extends State<TruckForm> {
  final _formKey = GlobalKey<FormState>();
  final _plate = TextEditingController();
  final _serial = TextEditingController();
  final _alias = TextEditingController();
  List<Truck> _item = [];

  @override
  void dispose() {
    _plate.dispose();
    _serial.dispose();
    _alias.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Camiones',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: AppResponsive.of(context).hp(3),
            ),
            BaseTextFormField(
              hintText: 'Placa',
              controller: _plate,
            ),
            SizedBox(
              height: AppResponsive.of(context).hp(3),
            ),
            BaseTextFormField(
              hintText: 'Serial',
              controller: _serial,
            ),
            SizedBox(
              height: AppResponsive.of(context).hp(3),
            ),
            BaseTextFormField(
              hintText: 'Alias',
              controller: _alias,
            ),
            SizedBox(
              height: AppResponsive.of(context).hp(3),
            ),
            BlocConsumer<TruckBloc, TruckState>(
              listener: (context, state) {
                if (state is TruckSuccess) {
                  AppMessages.saveMessage(context, 'Guardado!');
                }
              },
              builder: (context, state) {
                if (state is TruckLoading) {
                  return CircularProgressIndicator(
                    backgroundColor: AppColor.kBlue,
                  );
                } else {
                  return ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(AppColor.kYellow),
                    ),
                    onPressed: () => {
                      BlocProvider.of<TruckBloc>(context).add(
                        TruckeSaved(
                          truck: Truck(
                            plate: _plate.text,
                            serial: _serial.text,
                            alias: _alias.text,
                          ),
                        ),
                      )
                    },
                    child: Text('Guardar'),
                  );
                }
              },
            ),
            SizedBox(
              height: AppResponsive.of(context).hp(3),
            ),
            Divider(),
            Center(
              child: SizedBox(
                height: AppResponsive.of(context).hp(5),
                child: Text('Detalle'),
              ),
            ),
            Container(
              height: AppResponsive.of(context).hp(30),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    style: BorderStyle.solid,
                  ),
                ),
                elevation: 5,
                child: BlocConsumer<TruckBloc, TruckState>(
                  listener: (context, state) {
                    if (state is TruckListeUpdated) {
                      _item = state.trucks;
                    }
                  },
                  builder: (_, __) => ListView.builder(
                    itemBuilder: (context, index) => ListTile(
                      leading: Text((index + 1).toString()),
                      title: Text(
                        _item[index].plate,
                      ),
                      subtitle: Text(
                        '${_item[index].serial} (${_item[index].alias})',
                      ),
                      trailing: Icon(
                        Icons.car_rental,
                        color: (index + 1) % 2 != 0
                            ? AppColor.kBlue
                            : AppColor.kYellow,
                      ),
                    ),
                    itemCount: _item.length,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
