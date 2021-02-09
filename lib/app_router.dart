import 'package:flutter/material.dart';
import 'package:flutter_shoppinglist/home/home_screen.dart';
import 'package:flutter_shoppinglist/login/login_screen.dart';
import 'package:flutter_shoppinglist/personal_shoppinglist/personal_shoppinglist_screen.dart';
import 'package:flutter_shoppinglist/shoppinglist/shoppinglist_screen.dart';
import 'package:flutter_shoppinglist/splash/splash_screen.dart';
import 'package:flutter_shoppinglist/splash_two/splash_two_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );

      case '/splash':
        return MaterialPageRoute(
          builder: (_) => SplashScreen(),
        );

      case '/splashtwo':
        return MaterialPageRoute(
          builder: (_) => SplashTwoScreen(),
        );

      case '/login':
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );

      case '/personal':
        return MaterialPageRoute(
          builder: (_) => PersonalShoppinglistScreen(),
        );

      case '/shoppinglist':
        final shoppinglistId = args as String;

        return MaterialPageRoute(
          builder: (_) => ShoppinglistScreen(
            shoppinglistId: shoppinglistId,
          ),
        );

      default:
        return null;
    }
  }
}
