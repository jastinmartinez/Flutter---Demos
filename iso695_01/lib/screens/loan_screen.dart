import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iso695_01/Logic/loan.dart';
import 'package:provider/provider.dart';

class LoanScreen extends StatefulWidget {
  @override
  _LoanScreenState createState() => _LoanScreenState();
}

class _LoanScreenState extends State<LoanScreen> {
  final _formKey = new GlobalKey<FormState>();
  final _amount = new TextEditingController();
  final _interest = new TextEditingController();
  final _year = new TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _year.dispose();
    _amount.dispose();
    _interest.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ejercicio Calculo Interes'),
        backgroundColor: const Color(0xFF035AA6),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Cantidad'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                  ],
                  controller: _amount,
                  validator: (employeeSalary) {
                    if (employeeSalary.isEmpty) {
                      return 'Digite Cantidad';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Interes'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                  ],
                  controller: _interest,
                  validator: (employeeSalary) {
                    if (employeeSalary.isEmpty) {
                      return 'Digite Interes';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Años'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                  ],
                  controller: _year,
                  validator: (employeeSalary) {
                    if (employeeSalary.isEmpty) {
                      return 'Digite Años';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                FlatButton(
                  color: Colors.amber,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Provider.of<Loan>(context, listen: false).loanCalc(
                        amount: double.parse(_amount.text),
                        interest: double.parse(_interest.text),
                        year: int.parse(_year.text),
                      );
                    }
                  },
                  child: Text('Guardar'),
                ),
                SizedBox(
                  height: 30,
                ),
                Consumer<Loan>(
                  builder: (ctx, value, child) => ListView.builder(
                    shrinkWrap: true,
                    itemCount: value.result.length,
                    itemBuilder: (context, index) => ListTile(
                      title: Text(
                        value.result.keys.elementAt(index).toString(),
                      ),
                      subtitle: ListView(
                        shrinkWrap: true,
                        children: [
                          Text(
                            'Renta: \$' +
                                value.result[value.result.keys.elementAt(index)]
                                        ['Renta']
                                    .toStringAsFixed(2),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Interes: \$' +
                                value.result[value.result.keys.elementAt(index)]
                                        ['Interes']
                                    .toStringAsFixed(2),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Amortizacion: \$' +
                                value.result[value.result.keys.elementAt(index)]
                                        ['Amortizacion']
                                    .toStringAsFixed(2),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Saldo: \$' +
                                value.result[value.result.keys.elementAt(index)]
                                        ['Saldo']
                                    .toStringAsFixed(2),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
