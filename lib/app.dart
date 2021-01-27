import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shoppinglist/app_router.dart';
import 'package:flutter_shoppinglist/providers/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_shoppinglist/providers/blocs/items/items_bloc.dart';
import 'package:flutter_shoppinglist/providers/blocs/shoppinglist/shoppinglist_bloc.dart';
import 'package:flutter_shoppinglist/providers/repositories/authentication/authentication_repository.dart';
import 'package:flutter_shoppinglist/providers/repositories/items/items_repository.dart';
import 'package:flutter_shoppinglist/providers/repositories/shoppinglists/shoppinglists_repository.dart';
import 'package:flutter_shoppinglist/providers/repositories/stream_repository.dart';
import 'package:flutter_shoppinglist/theme.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();
  final AuthenticationRepository authenticationRepository;
  final ItemsRepository itemsRepository;
  final ShoppinglistsRepository shoppinglistsRepository;
  final StreamRepository streamRepository;

  App({
    Key key,
    @required this.authenticationRepository,
    @required this.itemsRepository,
    @required this.shoppinglistsRepository,
    @required this.streamRepository,
  })  : assert(authenticationRepository != null),
        assert(itemsRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthenticationBloc(
              authenticationRepository: authenticationRepository,
            ),
          ),
          BlocProvider(
            create: (context) => ItemsBloc(
              itemsRepository: itemsRepository,
            ),
          ),
          BlocProvider(
            create: (context) => ShoppinglistBloc(
              shoppinglistsRepository: shoppinglistsRepository,
            ),
          ),
        ],
        child: ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
          builder: (context, child) {
            final themeProvider = Provider.of<ThemeProvider>(context);

            return MaterialApp(
              title: 'Personal Shopper',
              debugShowCheckedModeBanner: false,
              navigatorKey: _navigatorKey,
              themeMode: themeProvider.themeMode,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              initialRoute: '/splash',
              onGenerateRoute: AppRouter().onGenerateRoute,
            );
          },
        ),
      ),
    );
  }
}
