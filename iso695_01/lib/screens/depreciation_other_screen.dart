import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iso695_01/Logic/depreciation_calc.dart';
import 'package:provider/provider.dart';

class DepreciationOtherScreen extends StatelessWidget {
  final _formKey = new GlobalKey<FormState>();
  final _assetValueController = new TextEditingController();
  final _lifeTimeController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF035AA6),
        title: Text(
          'Calculo Depreciacion (Suma Digitos)',
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
                  SizedBox(
                    height: 20,
                  ),
                  FlatButton(
                    onPressed: () {
                      if (_formKey.currentState.validate())
                        Provider.of<DepreciationCalc>(context, listen: false)
                            .deprCalcDigitSum(
                          assetValue: double.parse(_assetValueController.text),
                          lifeTime: int.parse(_lifeTimeController.text),
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
                    builder: (ctx, value, child) => ExpansionTile(
                      title: Text('Resultado'),
                      children: [
                        ExpansionTile(
                          title: Text('Depreciacion Anual'),
                          children: [
                            LimitedBox(
                              maxHeight: 600,
                              child: ListView.builder(
                                itemBuilder: (context, index) => ListTile(
                                  title: Text(
                                    value.calcResult2.keys
                                        .elementAt(index)
                                        .toString(),
                                  ),
                                  subtitle: Text('Año'),
                                  trailing: Text(
                                    '\$' +
                                        value.calcResult2.values
                                            .elementAt(index)
                                            .toStringAsFixed(2),
                                  ),
                                ),
                                itemCount: value.calcResult2.length,
                              ),
                            ),
                          ],
                        ),
                        ExpansionTile(
                          title: Text('Depreciacion Acumulada'),
                          children: [
                            LimitedBox(
                              maxHeight: 600,
                              child: ListView.builder(
                                itemBuilder: (context, index) => ListTile(
                                  title: Text(
                                    value.calcResult2.keys
                                        .elementAt(index)
                                        .toString(),
                                  ),
                                  subtitle: Text('Año'),
                                  trailing: Text('\$' +
                                      value.calcResult2.values
                                          .elementAt(index)
                                          .toStringAsFixed(2)),
                                ),
                                itemCount: value.calcResult2.length,
                              ),
                            ),
                          ],
                        ),
                      ],
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
