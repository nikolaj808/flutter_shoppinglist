import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shoppinglist/app.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shoppinglist/providers/repositories/authentication/authentication_repository.dart';
import 'package:flutter_shoppinglist/providers/repositories/items/items_repository.dart';
import 'package:flutter_shoppinglist/providers/repositories/shoppinglists/shoppinglists_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );

  runApp(
    App(
      authenticationRepository: AuthenticationRepository(),
      itemsRepository: ItemsRepository(),
      shoppinglistsRepository: ShoppinglistsRepository(),
    ),
  );
}
