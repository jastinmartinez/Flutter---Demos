import 'package:flutter/material.dart';

class DepreciationCalc extends ChangeNotifier {
  Map<String, int> get calcResult {
    return _calcResult;
  }

  Map<String, int> _calcResult = {
    'Depreciacion': 0,
  };

  void deprCalcRectLine({
    int assetValue,
    int lifeTime,
    int rescueValue,
  }) {
    if (rescueValue > 0) {
      _calcResult.addAll(
        {
          'Depreciacion': ((assetValue - rescueValue) ~/ lifeTime),
        },
      );
    } else {
      _calcResult.addAll(
        {
          'Depreciacion': (assetValue ~/ lifeTime),
        },
      );
    }
    notifyListeners();
  }

  Map<int, double> get calcResult2 {
    return _calcResult2;
  }

  Map<int, double> _calcResult2 = {0: 0};

  void deprCalcDigitSum({
    double assetValue,
    int lifeTime,
  }) {
    _calcResult2 = {1: 0};
    int _newlifeTime = 0;

    for (int i = lifeTime; i >= 0; i--) {
      _newlifeTime += i;
    }

    int yearOrder = lifeTime;

    for (int i = 1; i <= lifeTime; i++) {
      _calcResult2.addAll(
        {
          i: ((yearOrder--) / _newlifeTime) * (assetValue - (assetValue * 0.18))
        },
      );
    }
    notifyListeners();
  }
}
