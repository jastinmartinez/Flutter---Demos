import 'package:flutter/material.dart';
import 'package:iso695_01/Logic/depreciation_calc.dart';
import 'package:iso695_01/Logic/first_parcial.dart';
import 'package:iso695_01/Logic/loan.dart';
import 'package:iso695_01/Logic/salary_discount.dart';
import 'package:iso695_01/Logic/second_partial.dart';
import 'package:iso695_01/screens/coins_breakdown_screen.dart';

import 'package:iso695_01/screens/salary_discount_screen.dart';
import 'package:iso695_01/screens/triangulo_screen.dart';

import 'package:provider/provider.dart';

import 'Logic/coins_breakdown.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CoinsBreakDown(),
        ),
        ChangeNotifierProvider(
          create: (context) => SalaryDiscount(),
        ),
        ChangeNotifierProvider(
          create: (context) => DepreciationCalc(),
        ),
        ChangeNotifierProvider(
          create: (context) => FirstParcial(),
        ),
        ChangeNotifierProvider(
          create: (context) => Loan(),
        ),
        ChangeNotifierProvider(
          create: (context) => SecondPartial(),
        ),
      ],
      child: MaterialApp(
        title: 'Ejercicio # 1',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: TrianguloScreen(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF035AA6),
        title: Text(' Ejercicio # 1'),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(20),
          child: ListView(
            shrinkWrap: true,
            children: [
              FlatButton(
                color: Colors.amber,
                child: Text(
                  'Desglose de Monedas',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CoinsBreakdownScreen(),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              FlatButton(
                color: Colors.amber,
                child: Text(
                  'Calculo Salario',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SalaryDiscountScreen(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
