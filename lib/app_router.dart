import 'package:flutter/material.dart';
import 'package:flutter_shoppinglist/home/home_screen.dart';
import 'package:flutter_shoppinglist/login/login_screen.dart';
import 'package:flutter_shoppinglist/splash/splash_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );

      case '/splash':
        return MaterialPageRoute(
          builder: (_) => SplashScreen(),
        );

      case '/login':
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );

      default:
        return null;
    }
  }
}
