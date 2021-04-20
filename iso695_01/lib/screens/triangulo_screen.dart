import 'dart:math';

import 'package:flutter/material.dart';

class TrianguloScreen extends StatefulWidget {
  @override
  _TrianguloScreenState createState() => _TrianguloScreenState();
}

class _TrianguloScreenState extends State<TrianguloScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: FlatButton(
            child: Text('Cargar'),
            onPressed: () {
              int ladoA = 20;
              int ladoB = 20;
              int ladoC = 35;
              bool isEqual = false;
              if (ladoA == ladoB && ladoA == ladoC) isEqual = true;
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) => AlertDialog(
                  title: Text('Triangulo Equilatero'),
                  content: Text(
                    isEqual
                        ? 'Es Equilatero'
                        : 'No es Equilatero y el mayor es: ' +
                            [ladoA, ladoB, ladoC].reduce(max).toString(),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Ok'),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
