import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iso695_01/Logic/second_partial.dart';
import 'package:provider/provider.dart';

class SecondParcial3Screen extends StatefulWidget {
  @override
  _SecondParcial3ScreenState createState() => _SecondParcial3ScreenState();
}

class _SecondParcial3ScreenState extends State<SecondParcial3Screen> {
  final _formKey = new GlobalKey<FormState>();
  List<TextEditingController> _controller =
      List.generate(10, (i) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Segundo Parcial Ejercicio 3'),
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
                      decoration: InputDecoration(labelText: 'Valores'),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                      ],
                      controller: _controller[index],
                      validator: (amount) {
                        if (amount.isEmpty) {
                          return 'Digite Valores';
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
                    Provider.of<SecondPartial>(context, listen: false)
                        .program3(temValue);
                  }
                },
                child: Text('Guardar'),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 200,
                child: Consumer<SecondPartial>(
                  builder: (ctx, value, child) => ListView.builder(
                    shrinkWrap: true,
                    itemCount: value.result3.length,
                    itemBuilder: (context, index) => ListTile(
                      title: Text(
                        value.result3.keys.elementAt(index),
                      ),
                      subtitle: Text(
                        value.result3[value.result3.keys.elementAt(index)]
                            .toString(),
                      ),
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
