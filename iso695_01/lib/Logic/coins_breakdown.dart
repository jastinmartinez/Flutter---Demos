import 'package:flutter/material.dart';

class CoinsBreakDown extends ChangeNotifier {
  Map<String, int> get breakdownResult {
    return _breakdownResult;
  }

  Map<String, int> _breakdownResult = {
    'Papeletas de 2000': 0,
    'Papeletas de 1000': 0,
    'Papeletas de 500': 0,
    'Papeletas de 200': 0,
    'Papeletas de 100': 0,
    'Papeletas de 50': 0,
    'Monedas de 25': 0,
    'Monedas de 10': 0,
    'Monedas de 5': 0,
    'Monedas de 1': 0,
  };

  void breakdown(int amount) {
    _breakdownResult = {
      'Papeletas de 2000': 0,
      'Papeletas de 1000': 0,
      'Papeletas de 500': 0,
      'Papeletas de 200': 0,
      'Papeletas de 100': 0,
      'Papeletas de 50': 0,
      'Monedas de 25': 0,
      'Monedas de 10': 0,
      'Monedas de 5': 0,
      'Monedas de 1': 0,
    };

    if (amount >= 2000) {
      _breakdownResult.addAll(
        {
          'Papeletas de 2000': (amount ~/ 2000),
        },
      );
      amount = (amount - ((amount ~/ 2000) * 2000));
    }
    if (amount >= 1000) {
      _breakdownResult.addAll(
        {
          'Papeletas de 1000': (amount ~/ 1000),
        },
      );
      amount = (amount - ((amount ~/ 1000) * 1000));
    }
    if (amount >= 500) {
      _breakdownResult.addAll(
        {
          'Papeletas de 500': (amount ~/ 500),
        },
      );
      amount = (amount - ((amount ~/ 500) * 500));
    }
    if (amount >= 200) {
      _breakdownResult.addAll(
        {
          'Papeletas de 200': (amount ~/ 200),
        },
      );
      amount = (amount - ((amount ~/ 200) * 200));
    }
    if (amount >= 100) {
      _breakdownResult.addAll(
        {
          'Papeletas de 100': (amount ~/ 100),
        },
      );
      amount = (amount - ((amount ~/ 100) * 100));
    }
    if (amount >= 50) {
      _breakdownResult.addAll(
        {
          'Papeletas de 50': (amount ~/ 50),
        },
      );
      amount = (amount - ((amount ~/ 50) * 50));
    }
    if (amount >= 25) {
      _breakdownResult.addAll(
        {
          'Monedas de 25': (amount ~/ 25),
        },
      );
      amount = (amount - ((amount ~/ 25) * 25));
    }
    if (amount >= 10) {
      _breakdownResult.addAll(
        {
          'Monedas de 10': (amount ~/ 10),
        },
      );
      amount = (amount - ((amount ~/ 10) * 10));
    }
    if (amount >= 5) {
      _breakdownResult.addAll(
        {
          'Monedas de 5': (amount ~/ 5),
        },
      );
      amount = (amount - ((amount ~/ 5) * 5));
    }
    if (amount >= 1) {
      _breakdownResult.addAll(
        {
          'Monedas de 1': amount,
        },
      );
    }
    notifyListeners();
  }
}
