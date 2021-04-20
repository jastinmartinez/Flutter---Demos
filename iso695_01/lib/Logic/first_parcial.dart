import 'package:flutter/material.dart';

class FirstParcial extends ChangeNotifier {
  //ejercicio 1
  Map<String, int> get result1 {
    return _result1;
  }

  Map<String, int> _result1 = {
    'Salarios entre \$10,000 y \$30,000': 0,
    'Salarios mayor a \$30,000': 0,
  };

  void getSalary(int salary) {
    if (salary > 30000) {
      _result1['Salarios mayor a \$30,000'] += 1;
    } else if (salary <= 30000 && salary >= 10000) {
      _result1['Salarios entre \$10,000 y \$30,000'] += 1;
    }
    notifyListeners();
  }

// Ejercicio 2
  Map<String, int> get result2 {
    return _result2;
  }

  Map<String, int> _result2 = {
    'Suma': 0,
    'Promedio': 0,
  };
  void getValues(List<int> value) {
    _result2['Suma'] = value.reduce((a, b) => a + b);
    _result2['Promedio'] = (value.reduce((a, b) => a + b) ~/ value.length);

    notifyListeners();
  }

  // Ejercicio 3
  Map<String, int> get result3 {
    return _result3;
  }

  Map<String, int> _result3 = {
    'Promedio': 0,
  };
  void getScore(List<int> value) {
    _result3['Promedio'] = (value.reduce((a, b) => a + b) ~/ value.length);
    notifyListeners();
  }
}
