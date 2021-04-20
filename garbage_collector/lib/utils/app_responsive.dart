import 'dart:math';

import 'package:flutter/material.dart';

class AppResponsive {
  double _width, _height, _diagonal;
  bool _isTablet;

  double get width => _width;
  double get height => _height;
  double get diagonal => _diagonal;
  bool get isTablet => _isTablet;
  static AppResponsive of(BuildContext context) => AppResponsive(context);

  AppResponsive(BuildContext context) {
    final size = MediaQuery.of(context).size;
    this._width = size.width;
    this._height = size.height;
    this._diagonal = sqrt(
      pow(_width, 2) + pow(_height, 2),
    );

    this._isTablet = size.shortestSide > 600;
  }
  double wp(double percent) => _width * percent / 100;
  double hp(double percent) => _height * percent / 100;
  double dp(double percent) => _diagonal * percent / 100;
}
