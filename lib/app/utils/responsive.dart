import 'dart:math';
import 'package:flutter/material.dart';

class Responsive{
  double? _width, _height, _diagonal;
  bool _isTabllet = false;

  double get width => _width!;
  double get height => _height!;
  double get diagonal => _diagonal!;
  bool get isTabllet => _isTabllet;

  static Responsive of(BuildContext context) => Responsive(context);
  
  Responsive(BuildContext context){
    final size = MediaQuery.of(context).size;
    _width = size.width;
    _height = size.height;
    
    _diagonal = sqrt(pow(_width!, 2)+ pow(_height!, 2));

    _isTabllet = size.shortestSide >= 600;
    
  }

  double wp(double percent) => _width! * percent / 100;
  double hp(double percent) => _height! * percent / 100;
  double dp(double percent) => _diagonal! * percent / 100;

}