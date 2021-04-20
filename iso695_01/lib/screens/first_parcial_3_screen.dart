import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iso695_01/Logic/first_parcial.dart';
import 'package:provider/provider.dart';

class FirstParcial3Screen extends StatefulWidget {
  @override
  _FirstParcial3ScreenState createState() => _FirstParcial3ScreenState();
}

class _FirstParcial3ScreenState extends State<FirstParcial3Screen> {
  final _formKey = new GlobalKey<FormState>();
  List<TextEditingController> _controller =
      List.generate(10, (i) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Primer Parcial Ejercicio 3'),
        backgroundColor: const Color(0xFF035AA6),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              LimitedBox(
                maxHeight: 400,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _controller.length,
                  itemBuilder: (context, index) => ListTile(
                    leading: Text((index + 1).toString()),
                    title: TextFormField(
                      decoration: InputDecoration(labelText: 'Cantidad'),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                      ],
                      controller: _controller[index],
                      validator: (amount) {
                        if (amount.isEmpty) {
                          return 'Digite Cantidad';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FlatButton(
                color: Colors.amber,
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    List<int> temValue = [];
                    _controller.forEach(
                      (element) {
                        temValue.add(int.parse(element.text));
                      },
                    );
                    Provider.of<FirstParcial>(context, listen: false)
                        .getScore(temValue);
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
                  itemCount: value.result3.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(
                      value.result3.keys.elementAt(index),
                    ),
                    subtitle: Text(
                      value.result3[value.result3.keys.elementAt(index)] >= 70
                          ? 'Promovido'
                          : (value.result3[value.result3.keys
                                          .elementAt(index)] >=
                                      40 &&
                                  value.result3[value.result3.keys
                                          .elementAt(index)] <=
                                      70)
                              ? 'Regular'
                              : (value.result3[value.result3.keys
                                          .elementAt(index)] ==
                                      0)
                                  ? ''
                                  : 'Reprobado',
                    ),
                    leading: Icon(
                      Icons.info,
                      color:
                          value.result3[value.result3.keys.elementAt(index)] >=
                                  70
                              ? Colors.green
                              : (value.result3[value.result3.keys
                                              .elementAt(index)] >=
                                          40 &&
                                      value.result3[value.result3.keys
                                              .elementAt(index)] <=
                                          70)
                                  ? Colors.orange
                                  : (value.result3[value.result3.keys
                                              .elementAt(index)] ==
                                          0)
                                      ? Colors.white
                                      : Colors.red,
                    ),
                    trailing: Text(
                      value.result3[value.result3.keys.elementAt(index)]
                          .toString(),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
