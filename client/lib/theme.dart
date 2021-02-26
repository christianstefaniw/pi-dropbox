import 'package:flutter/material.dart';

class MyTheme with ChangeNotifier{
  static bool _isDark = false;

  ThemeMode currentTheme(){
    return _isDark ? ThemeMode.dark : ThemeMode.light;
  }

  void switchTheme(){
    _isDark = !_isDark;
    notifyListeners();
  }
}

/*
primary: Color(0xff406AFF),
    secondary: Color(0xffFF7D1F),
    onPrimary: null,
 */