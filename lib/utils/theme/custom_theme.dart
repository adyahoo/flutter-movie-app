import 'package:flutter/material.dart';
import 'package:movie_app/utils/color_schemes.dart';
import 'package:movie_app/utils/theme/custom_text_theme.dart';

class CustomTheme {
  static ThemeData getLightTheme() => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: lightColorScheme,
        textTheme: CustomTextTheme.getTextTheme(),
      );
}
