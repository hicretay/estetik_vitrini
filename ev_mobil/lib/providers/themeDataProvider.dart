import 'package:estetikvitrini/settings/consts.dart';
import 'package:flutter/material.dart';

ThemeData light = ThemeData(
  backgroundColor: white,
  fontFamily: "futura_medium_bt"
);

ThemeData dark = ThemeData(
  backgroundColor: darkBg,
  fontFamily: "futura_medium_bt"
);

class ThemeDataProvider with ChangeNotifier{
  bool isLightTheme = true;

  ThemeData get themeColor {
    return isLightTheme ? light : dark;
  }

  void toggleTheme(){
    isLightTheme = !isLightTheme;
    notifyListeners();
  }
}