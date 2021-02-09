import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shoppinglist/providers/repositories/shoppinglists/shoppinglists_repository.dart';
import 'package:flutter_shoppinglist/providers/services/shared_preferences_service.dart';
import 'package:rive/rive.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  Future<void> _navigateToHomeScreen() async {
    await Future.delayed(
      const Duration(milliseconds: 100),
      () async {
        final bool loggedIn = FirebaseAuth.instance.currentUser != null;

        if (!loggedIn) {
          return Navigator.of(context).pushNamedAndRemoveUntil(
            '/login',
            (_) => false,
          );
        }

        final String previousListId = await SharedPreferencesService.getString(
          SharedPreferencesKey.previousList,
        );

        final bool previousListExists =
            await ShoppinglistsRepository().shoppinglistExists(
          previousListId,
        );

        if (previousListExists) {
          return Navigator.of(context).pushNamedAndRemoveUntil(
            '/shoppinglist',
            (route) => false,
            arguments: previousListId,
          );
        }

        Navigator.of(context).pushNamedAndRemoveUntil(
          '/personal',
          (route) => false,
        );
      },
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
      body: Center(
        child: _riveArtboard == null
            ? const SizedBox()
            : Rive(artboard: _riveArtboard),
      ),
    );
  }
}
