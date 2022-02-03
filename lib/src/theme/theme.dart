import 'package:flutter/material.dart';

final customTheme = ThemeData.dark().copyWith(
  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black12),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: Colors.red,
  ),
);
