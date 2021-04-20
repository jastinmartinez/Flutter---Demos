import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iso695_01/Logic/second_partial.dart';
import 'package:provider/provider.dart';

class SecondParcial1Screen extends StatefulWidget {
  @override
  _SecondParcial1ScreenState createState() => _SecondParcial1ScreenState();
}

class _SecondParcial1ScreenState extends State<SecondParcial1Screen> {
  final _formKey = new GlobalKey<FormState>();
  List<TextEditingController> _controller =
      List.generate(2, (i) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Segundo Parcial Ejercicio 1'),
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
                          labelText: 'Digitar valor ' + (index + 1).toString()),
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
                    Provider.of<SecondPartial>(context, listen: false).program1(
                      int.parse(_controller[0].text),
                      int.parse(_controller[1].text),
                    );
                  }
                },
                child: Text('Guardar'),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 400,
                child: Consumer<SecondPartial>(
                  builder: (ctx, value, child) => ListView.builder(
                    shrinkWrap: true,
                    itemCount: value.result1.length,
                    itemBuilder: (context, index) => ListTile(
                      title: Text(
                        value.result1.keys.elementAt(index).toString(),
                      ),
                      subtitle: Text(
                        value.result1[value.result1.keys.elementAt(index)]
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
