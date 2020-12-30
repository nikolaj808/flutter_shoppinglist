import 'package:flutter/material.dart';
import 'package:flutter_shoppinglist/screens/splash/splash_screen.dart';
import 'package:flutter_shoppinglist/theme.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Shopper',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: SplashScreen(),
    );
  }
}
