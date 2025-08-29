import 'package:flutter/material.dart';

import 'color_resources.dart';
import 'font_family.dart';


ThemeData light = ThemeData.light().copyWith(
  brightness: Brightness.light,
  primaryColor: ColorResources.primary,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
  cardColor: ColorResources.cardLight,
  cardTheme: CardTheme(
    color: ColorResources.cardLight,
    surfaceTintColor: ColorResources.cardLight,
  ),
  dividerColor: ColorResources.dividerLight,
  iconTheme: IconThemeData(color: ColorResources.icon),
  textTheme: TextTheme(
      displayLarge: FontFamily().medium.copyWith(color: ColorResources.textPrimary),
      titleMedium: FontFamily().medium.copyWith(color: ColorResources.textPrimary),
      bodyLarge: FontFamily().medium.copyWith(color: ColorResources.textPrimary),
      bodyMedium: FontFamily().medium.copyWith(color: ColorResources.textPrimary),
      bodySmall:FontFamily().medium.copyWith(color: ColorResources.textPrimary),
      labelLarge: FontFamily().medium.copyWith(color: ColorResources.textPrimary)
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: ColorResources.cardLight, // Set your desired fill color here
  ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorResources.cardLight,
    )
);

ThemeData dark = ThemeData.dark().copyWith(
  brightness: Brightness.dark,
  primaryColor: ColorResources.primary,
  cardColor: ColorResources.cardDark,
  cardTheme: CardTheme(
    color: ColorResources.cardDark,
    surfaceTintColor: ColorResources.cardDark,
  ),
  dividerColor: ColorResources.dividerDark,
  iconTheme: IconThemeData(color: ColorResources.icon),
  textTheme: TextTheme(
      displayLarge: FontFamily().medium.copyWith(color: ColorResources.textSecondary),
      titleMedium: FontFamily().medium.copyWith(color: ColorResources.textSecondary),
      bodyLarge: FontFamily().medium.copyWith(color: ColorResources.textSecondary),
      bodyMedium: FontFamily().medium.copyWith(color: ColorResources.textSecondary),
      bodySmall:FontFamily().medium.copyWith(color: ColorResources.textSecondary),
      labelLarge: FontFamily().medium.copyWith(color: ColorResources.textSecondary)
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: ColorResources.cardDark, // Set your desired fill color here
  ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorResources.cardDark,
    )
  // colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue).copyWith(background: Colors.black)
);