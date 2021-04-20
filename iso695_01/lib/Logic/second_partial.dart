import 'package:flutter/material.dart';

class SecondPartial extends ChangeNotifier {
  Map<int, Map<String, int>> get result1 => _result1;
  Map<int, Map<String, int>> _result1 = {
    0: {
      'Superficie Mayor a 12': 0,
    }
  };
  void program1(int base, int altura) {
    _result1.addAll(
      {
        _result1.length: {
          'Base': base,
          'Altura': altura,
          'Superficio': (base * altura) ~/ 2,
        },
      },
    );

    if (((base * altura) ~/ 2) > 12) {
      _result1[0]['Superficie Mayor a 12'] += 1;
    }
    notifyListeners();
  }

  Map<String, int> get result2 => _result2;
  Map<String, int> _result2 = {
    'Equilatero': 0,
    'Isoseles': 0,
    'Escaleno': 0,
  };
  void program2(int l1, int l2, int l3) {
    if (l1 == l2 && l2 == l3) {
      _result2['Equilatero'] += 1;
    }
    if (l1 == l2 || l1 == l3 || l2 == l3) {
      _result2['Isoseles'] += 1;
    }
    if (l1 != l2 || l1 != l3 || l2 != l3) {
      _result2['Escaleno'] += 1;
    }
    notifyListeners();
  }

  Map<String, int> get result3 => _result3;
  Map<String, int> _result3 = {
    'Valors Negativos': 0,
    'Valors Postivos': 0,
    'Multiplos de 15': 0,
    'Valores Pares': 0,
  };
  void program3(List<int> valor) async {
    _result3 = {
      'Valors Negativos': 0,
      'Valors Postivos': 0,
      'Multiplos de 15': 0,
      'Valores Pares': 0,
    };
    valor.forEach(
      (n) {
        if (n < 0) {
          _result3['Valors Negativos'] += 1;
        }
        if (n > 0) {
          _result3['Valors Postivos'] += 1;
        }
        if (n % 2 == 0) {
          _result3['Valores Pares'] += 1;
        }
        if (n % 15 == 0) {
          _result3['Multiplos de 15'] += 1;
        }
      },
    );
    notifyListeners();
  }
}
