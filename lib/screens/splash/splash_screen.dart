import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shoppinglist/screens/home/home_screen.dart';
import 'package:flutter_shoppinglist/screens/login/login_screen.dart';
import 'package:flutter_shoppinglist/screens/second_home/second_home_screen.dart';
import 'package:rive/rive.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  void _navigateToHomeScreen() async {
    await Future.delayed(
      Duration(milliseconds: 100),
      () => Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => SecondHomeScreen(),
        ),
        (route) => false,
      ),
    );
  }

  Artboard _riveArtboard;
  RiveAnimationController _controller;
  @override
  void initState() {
    super.initState();

    rootBundle.load('assets/shopping_cart.riv').then(
      (data) async {
        final file = RiveFile();

        if (file.import(data)) {
          final artboard = file.mainArtboard;

          artboard.addController(_controller = SimpleAnimation('Intro'));
          setState(() => _riveArtboard = artboard);

          _controller.isActiveChanged.addListener(_navigateToHomeScreen);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: _riveArtboard == null
              ? const SizedBox()
              : Rive(artboard: _riveArtboard),
        ),
      ),
    );
  }
}
