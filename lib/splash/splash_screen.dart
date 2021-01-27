import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shoppinglist/providers/blocs/items/items_bloc.dart';
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
      () {
        final loggedIn = FirebaseAuth.instance.currentUser == null;
        Navigator.of(context).pushNamedAndRemoveUntil(
          loggedIn ? '/login' : '/',
          (route) => false,
        );
        BlocProvider.of<ItemsBloc>(context).add(GetItems());
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
