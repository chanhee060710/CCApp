import 'package:ccapp_front/style/colors.dart';
import 'package:flutter/material.dart';

class CCTheme {
  static final theme = ThemeData(
    fontFamily: 'Pretendard',
    scaffoldBackgroundColor: CCColor.grey100,
    primaryColor: CCColor.primary,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: CCColor.primary,
      onPrimary: CCColor.primary,
      secondary: CCColor.secondary,
      onSecondary: CCColor.secondary,
      error: Colors.red,
      onError: Colors.red,
      background: CCColor.grey100,
      onBackground: CCColor.grey100,
      surface: CCColor.primary,
      onSurface: CCColor.primary,
    ),
  );
}
