import 'package:flutter/material.dart';

class AppModel {
  final ThemeData theme;
  AppModel({
    required this.theme,
  });


  AppModel copyWith({
    ThemeData? theme,
  }) {
    return AppModel(
      theme: theme ?? this.theme,
    );
  }
}
