import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextTheme {
  static final _baseTheme = GoogleFonts.dmSans().copyWith(color: Colors.black, fontWeight: FontWeight.w500);

  static TextTheme getTextTheme() => TextTheme(
        headlineLarge: _baseTheme.copyWith(fontSize: 24, fontWeight: FontWeight.w700),
        headlineMedium: _baseTheme.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        headlineSmall: _baseTheme.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        displayMedium: _baseTheme.copyWith(
          fontSize: 18,
        ),
        displaySmall: _baseTheme.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
        titleMedium: _baseTheme.copyWith(
          fontSize: 16,
        ),
        titleSmall: _baseTheme.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        labelMedium: _baseTheme.copyWith(
          fontSize: 14,
        ),
        labelSmall: _baseTheme.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: _baseTheme.copyWith(
          fontSize: 12,
        ),
        bodySmall: _baseTheme.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      );
}
