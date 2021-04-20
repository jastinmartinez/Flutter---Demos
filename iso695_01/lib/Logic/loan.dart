import 'dart:math';

import 'package:flutter/material.dart';

class Loan extends ChangeNotifier {
  Map<int, Map<String, double>> get result {
    return _result;
  }

  Map<int, Map<String, double>> _result = {
    1: {
      'Renta': 0,
      'Interes': 0,
      'Amortizacion': 0,
      'Saldo': 0,
    }
  };

  void loanCalc({
    double interest,
    double amount,
    int year,
  }) {
    int year2 = year;

    double interes = 0;
    double renta = 0;
    for (int periodo = 1; periodo <= year; periodo++) {
      interes = (amount * (interest / 100));
      renta = (amount * (interest / 100)) /
          (1 - pow((1 + (interest / 100)), -(year2--)));

      _result.addAll(
        {
          periodo: {
            'Renta': renta,
            'Interes': interes,
            'Amortizacion': renta - interes,
            'Saldo': amount - (renta - interes),
          }
        },
      );
      amount -= (renta - interes);
    }
    notifyListeners();
  }
}
