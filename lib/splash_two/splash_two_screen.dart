import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shoppinglist/login/login_screen.dart';
import 'package:flutter_shoppinglist/personal_shoppinglist/cubit/personal_shoppinglist_cubit.dart';
import 'package:flutter_shoppinglist/personal_shoppinglist/personal_shoppinglist_screen.dart';
import 'package:flutter_shoppinglist/providers/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_shoppinglist/providers/blocs/shoppinglists/shoppinglists_bloc.dart';
import 'package:flutter_shoppinglist/providers/repositories/shoppinglists/shoppinglists_repository.dart';
import 'package:flutter_shoppinglist/providers/services/shared_preferences_service.dart';
import 'package:flutter_shoppinglist/shoppinglist/shoppinglist_screen.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashTwoScreen extends StatefulWidget {
  @override
  _SplashTwoScreenState createState() => _SplashTwoScreenState();
}

class _SplashTwoScreenState extends State<SplashTwoScreen> {
  Widget route = LoginScreen();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) async {
        if (state.status == AuthenticationStatus.authenticated) {
          BlocProvider.of<PersonalShoppinglistCubit>(context)
              .getPersonalShoppinglist();
          BlocProvider.of<ShoppinglistsBloc>(context).add(GetShoppinglists());

          final String previousListId =
              await SharedPreferencesService.getString(
            SharedPreferencesKey.previousList,
          );

          final bool previousListExists =
              await ShoppinglistsRepository().shoppinglistExists(
            previousListId,
          );

          if (previousListExists) {
            if (mounted) {
              setState(() {
                route = ShoppinglistScreen(shoppinglistId: previousListId);
              });
            }
          } else {
            if (mounted) {
              setState(() {
                route = PersonalShoppinglistScreen();
              });
            }
          }
        }
      },
      child: SplashScreen(
        image: Image.asset('assets/shopping-cart.png'),
        title: Text(
          'Personal Shopper',
          style: Theme.of(context).textTheme.headline4.copyWith(
                fontFamily: 'Roboto',
              ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        photoSize: 64,
        navigateAfterSeconds: route,
        seconds: 1,
      ),
    );
  }
}
