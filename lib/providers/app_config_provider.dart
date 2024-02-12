

import 'package:flutter/material.dart';

class AppConfigProvider extends ChangeNotifier{
  var appLanguage='en';
  var appMode=ThemeMode.light;

  void ChangeLanguage(String lang){
    if(appLanguage==lang){
      return;
    }
    appLanguage=lang;
    notifyListeners();
  }

  void ChangeAppThemeMode(ThemeMode appThemeMode){
    if(appMode == appThemeMode){
      return;
    }
    appMode=appThemeMode;
    notifyListeners();
  }
}