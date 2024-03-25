import 'package:flutter/material.dart';

import '../color_schemes.dart';
import 'custom_text_theme.dart';

class CustomTheme {
  static ThemeData getLightTheme() => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: lightColorScheme,
        textTheme: CustomTextTheme.getTextTheme(),
      );
}
