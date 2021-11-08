import 'package:estetikvitrini/settings/consts.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeData light = ThemeData(
  backgroundColor: white,
  hintColor: darkBg,
  fontFamily: "futura_medium_bt",
);

ThemeData dark = ThemeData(
  backgroundColor: darkBg,
  hintColor: white,
  fontFamily: "futura_medium_bt",   
);

class ThemeDataProvider with ChangeNotifier{
  bool isLightTheme = true;
  static SharedPreferences _preferences;

  ThemeData get themeColor {
    return isLightTheme ? light : dark;
  }

  void toggleTheme(){
    isLightTheme = !isLightTheme;
    isLightTheme?iconCol=darkBg:iconCol=white;
    saveTheme(isLightTheme);
    notifyListeners();
  }


  Future<void> createSharedPrefObj()async{
    _preferences = await SharedPreferences.getInstance();
  }

  void saveTheme(bool value){
    _preferences.setBool("themeData", value);
  }

  void loadTheme()async{
    isLightTheme = _preferences.getBool("themeData") ?? true;
  }
}