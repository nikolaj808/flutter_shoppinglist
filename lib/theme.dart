import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme({bool isOn}) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class AppTheme {
  static final ThemeData darkTheme = ThemeData(
    fontFamily: 'RobotoMono',
    scaffoldBackgroundColor: const Color(0xFF121212),
    backgroundColor: const Color(0xFF1D1D1D),
    primaryColor: Colors.purple[200],
    accentColor: Colors.teal[200],
    dividerColor: Colors.white,
    colorScheme: const ColorScheme.dark(),
    iconTheme: const IconThemeData(color: Colors.white),
    primaryIconTheme: const IconThemeData(color: Colors.white),
    errorColor: const Color(0xFFB00020),
  );

  static final ThemeData lightTheme = ThemeData(
    fontFamily: 'RobotoMono',
    scaffoldBackgroundColor: Colors.white,
    backgroundColor: Colors.white,
    primaryColor: Colors.purple[800],
    accentColor: Colors.teal[500],
    dividerColor: Colors.black,
    colorScheme: const ColorScheme.light(),
    iconTheme: const IconThemeData(color: Colors.black),
    primaryIconTheme: const IconThemeData(color: Colors.black),
    errorColor: const Color(0xFFB00020),
  );
}
