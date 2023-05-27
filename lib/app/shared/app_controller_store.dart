import 'package:flutter/material.dart';
import 'package:lumiere/app/shared/core/themes/theme_service.dart';
import 'package:lumiere/app/shared/models/app_model.dart';

// ignore: must_be_immutable
class AppControllerStore extends ValueNotifier<AppModel> {
  final ThemeService _themeService;

  AppModel appModel = AppModel(theme: ThemeData());

  AppControllerStore(this._themeService)
      : super(AppModel(theme: _themeService.darkTheme)) {
    getTheme();
  }

  bool get isDark => appModel.theme.brightness == Brightness.dark;

  ThemeData? get theme => appModel.theme;

  Future<void> getTheme() async {
    ThemeData theme = _themeService.darkTheme;

    theme = await _themeService.getTheme();
    
    appModel = appModel.copyWith(theme: theme);

    value = appModel;
  }

  Future<void> toggleTheme() async {
    ThemeData theme = await _themeService.toggleTheme(appModel.theme);

    appModel = appModel.copyWith(theme: theme);

    value = appModel;
  }

  
}
