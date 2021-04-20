import 'package:flutter/material.dart';

class SalaryDiscount extends ChangeNotifier {
  final double afpDiscount = 0.0304;
  final double arsDiscount = 0.0287;

  Map<String, double> get salaryDiscountResult {
    return _salaryDiscountResult;
  }

  Map<String, double> _salaryDiscountResult = {
    'AFP': 0,
    'ARS': 0,
  };

  void salaryDiscount(double salary) {
    _salaryDiscountResult.addAll(
      {
        'AFP': salary * afpDiscount,
        'ARS': salary * arsDiscount,
      },
    );
    notifyListeners();
  }
}
