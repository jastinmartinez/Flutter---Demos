import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iso695_01/Logic/second_partial.dart';
import 'package:provider/provider.dart';

class SecondParcial2Screen extends StatefulWidget {
  @override
  _SecondParcial2ScreenState createState() => _SecondParcial2ScreenState();
}

class _SecondParcial2ScreenState extends State<SecondParcial2Screen> {
  final _formKey = new GlobalKey<FormState>();
  List<TextEditingController> _controller =
      List.generate(3, (i) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Segundo Parcial Ejercicio 2'),
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
                      decoration: InputDecoration(
                          labelText: 'Digitar lado ' + (index + 1).toString()),
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
                    Provider.of<SecondPartial>(context, listen: false).program2(
                      int.parse(_controller[0].text),
                      int.parse(_controller[1].text),
                      int.parse(_controller[2].text),
                    );
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
                    itemCount: value.result2.length,
                    itemBuilder: (context, index) => ListTile(
                      title: Text(
                        value.result2.keys.elementAt(index),
                      ),
                      subtitle: Text(
                        value.result2[value.result2.keys.elementAt(index)]
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
