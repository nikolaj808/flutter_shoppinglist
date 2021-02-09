import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shoppinglist/providers/services/shared_preferences_service.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  Future<void> initializeTheme() async {
    final bool isOn = await SharedPreferencesService.getBool(
      SharedPreferencesKey.themeMode,
    );

    if (isOn != null) {
      themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    } else {
      themeMode = ThemeMode.system;
    }

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    notifyListeners();
  }

  Future<void> toggleTheme({bool isOn}) async {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;

    await SharedPreferencesService.setBool(
      SharedPreferencesKey.themeMode,
      value: isOn,
    );

    return notifyListeners();
  }
}

class AppTheme {
  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    appBarTheme: const AppBarTheme(brightness: Brightness.dark),
    primaryColor: Colors.orange,
    accentColor: Colors.indigo,
    primaryIconTheme: const IconThemeData(color: Colors.white),
  );

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    appBarTheme: const AppBarTheme(brightness: Brightness.light),
    primaryColor: Colors.orange,
    accentColor: Colors.indigo,
    primaryIconTheme: const IconThemeData(color: Colors.black),
  );
}
