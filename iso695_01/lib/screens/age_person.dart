import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AgePerson extends StatefulWidget {
  @override
  _AgePersonState createState() => _AgePersonState();
}

class _AgePersonState extends State<AgePerson> {
  final _formKey = new GlobalKey<FormState>();
  final _nameController = new TextEditingController();
  final _ageController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Validacion de edad'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nombre'),
                controller: _nameController,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Edad'),
                controller: _ageController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              SizedBox(
                height: 20,
              ),
              FlatButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    if (int.parse(_ageController.text) >= 18) {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) => AlertDialog(
                                title: Text('Verificador de edad'),
                                content: Text(
                                    _nameController.text + ' es mayor edad'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('Ok'),
                                  )
                                ],
                              ));
                    }
                  }
                },
                child: Text('Verificar Edad'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
