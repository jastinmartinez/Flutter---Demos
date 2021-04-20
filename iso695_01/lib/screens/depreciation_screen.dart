import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iso695_01/Logic/depreciation_calc.dart';
import 'package:provider/provider.dart';

class DepreciationScreen extends StatelessWidget {
  final _formKey = new GlobalKey<FormState>();
  final _assetValueController = new TextEditingController();
  final _lifeTimeController = new TextEditingController();
  final _rescueValueCotroller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF035AA6),
        title: Text(
          'Calculo Depreciacion (Linea Recta)',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: const Color(0xFF035AA6),
      body: Container(
        color: Colors.white,
        child: Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Valor'),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                    ],
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Digite valor de activo';
                      }
                      return null;
                    },
                    controller: _assetValueController,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Vida util'),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                    ],
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Digite vida util de activo';
                      }
                      return null;
                    },
                    controller: _lifeTimeController,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Valor de Rescate (Opcional)'),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                    ],
                    keyboardType: TextInputType.number,
                    controller: _rescueValueCotroller,
                    validator: (value) {
                      if (value.isEmpty) {
                        _rescueValueCotroller.text = '0';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FlatButton(
                    onPressed: () {
                      if (_formKey.currentState.validate())
                        Provider.of<DepreciationCalc>(context, listen: false)
                            .deprCalcRectLine(
                          assetValue: int.parse(_assetValueController.text),
                          lifeTime: int.parse(_lifeTimeController.text),
                          rescueValue: int.parse(_rescueValueCotroller.text),
                        );
                    },
                    child: Text('Calcular'),
                    color: Colors.amber,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 10,
                    color: Colors.blue,
                  ),
                  Consumer<DepreciationCalc>(
                    builder: (ctx, value, child) => LimitedBox(
                      maxHeight: 600,
                      child: ListView(
                        children: [
                          ListTile(
                            title: Text(
                              value.calcResult.keys.elementAt(0),
                            ),
                            subtitle: Text('\$' +
                                value.calcResult.values
                                    .elementAt(0)
                                    .toString()),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
