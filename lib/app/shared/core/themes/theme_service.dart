import 'package:flutter/material.dart';
import 'package:lumiere/app/shared/core/themes/dark_theme.dart';



class ThemeService {
  // ThemeService(Istorage themeRepository)
  //     : _themeRepository = themeRepository;

  // final Istorage _themeRepository;

  //ThemeData get lightTheme => LightTheme.lightTheme;

  ThemeData get darkTheme => DarkTheme.darkTheme;

  Future<ThemeData> getTheme() async {

    // String themeKey = await _themeRepository.getThemeKey();
    
    if (darkTheme == darkTheme) {

      return darkTheme;
    } else {
      // ignore: unrelated_type_equality_checks
      return darkTheme == "light" ? darkTheme : darkTheme;
    }
  }

  Future<ThemeData> toggleTheme(ThemeData theme) async {
    if (theme == darkTheme) {
      theme = darkTheme;
    } else {
      theme = darkTheme;
    }
    // String brightness = theme.brightness == Brightness.dark ? 'dark' : 'light';
    //_themeRepository.setThemeKey(brightness);
    

    return theme;
  }
}