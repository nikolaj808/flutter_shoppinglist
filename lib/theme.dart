import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData theme = ThemeData(
    brightness: Brightness.dark,
    iconTheme: IconThemeData(color: Colors.black),
    primarySwatch: Colors.amber,
    primaryColor: Colors.amber[600],
    primaryIconTheme: IconThemeData(color: Colors.black),
    primaryColorLight: Color(0xFFFFE54C),
    primaryColorDark: Color(0xFFC68400),
    primaryColorBrightness: Brightness.dark,
    accentColor: Colors.indigo[600],
    accentIconTheme: IconThemeData(color: Colors.white),
    accentColorBrightness: Brightness.dark,
    backgroundColor: Colors.white,
    dialogBackgroundColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
  );
}
