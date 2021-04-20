import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iso695_01/Logic/first_parcial.dart';
import 'package:provider/provider.dart';

class FirstParcial1Screen extends StatefulWidget {
  @override
  _FirstParcial1ScreenState createState() => _FirstParcial1ScreenState();
}

class _FirstParcial1ScreenState extends State<FirstParcial1Screen> {
  final _formKey = new GlobalKey<FormState>();
  final _employeeSalary = new TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _employeeSalary.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Primer Parcial Ejercicio 1'),
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
                  decoration: InputDecoration(labelText: 'Salario'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                  ],
                  controller: _employeeSalary,
                  validator: (employeeSalary) {
                    if (employeeSalary.isEmpty) {
                      return 'Digite salario';
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
                      Provider.of<FirstParcial>(context, listen: false)
                          .getSalary(
                        int.parse(_employeeSalary.text),
                      );
                      _employeeSalary.clear();
                    }
                  },
                  child: Text('Guardar'),
                ),
                SizedBox(
                  height: 30,
                ),
                Consumer<FirstParcial>(
                  builder: (ctx, value, child) => ListView.builder(
                    shrinkWrap: true,
                    itemCount: value.result1.length,
                    itemBuilder: (context, index) => ListTile(
                      title: Text(
                        value.result1.keys.elementAt(index),
                      ),
                      subtitle: Text(
                        value.result1[value.result1.keys.elementAt(index)]
                            .toString(),
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
