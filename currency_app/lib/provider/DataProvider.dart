import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangeTheme extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme() {
    themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyTheme {
  final darkTheme = ThemeData(
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    backgroundColor: const Color(0xFF212121),
    accentColor: Colors.white,
    accentIconTheme: const IconThemeData(color: Colors.white),
    dividerColor: Colors.white24,
  );

  final lightTheme = ThemeData(
    primaryColor: Colors.black,
    primaryIconTheme: IconThemeData(color: Colors.black),
    brightness: Brightness.light,
    backgroundColor: const Color(0xFFE5E5E5),
    accentColor: Colors.black,
    accentIconTheme: const IconThemeData(color: Colors.black),
    dividerColor: Colors.grey[300],
  );
}
