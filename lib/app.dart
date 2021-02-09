import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shoppinglist/app_router.dart';
import 'package:flutter_shoppinglist/personal_shoppinglist/cubit/personal_shoppinglist_cubit.dart';
import 'package:flutter_shoppinglist/providers/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_shoppinglist/providers/blocs/items/items_bloc.dart';
import 'package:flutter_shoppinglist/providers/blocs/shoppinglists/shoppinglists_bloc.dart';
import 'package:flutter_shoppinglist/providers/repositories/authentication/authentication_repository.dart';
import 'package:flutter_shoppinglist/providers/repositories/items/items_repository.dart';
import 'package:flutter_shoppinglist/providers/repositories/shoppinglists/shoppinglists_repository.dart';
import 'package:flutter_shoppinglist/shoppinglist/cubit/shoppinglist_cubit.dart';
import 'package:flutter_shoppinglist/theme.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();
  final AuthenticationRepository authenticationRepository;
  final ItemsRepository itemsRepository;
  final ShoppinglistsRepository shoppinglistsRepository;

  App({
    Key key,
    @required this.authenticationRepository,
    @required this.itemsRepository,
    @required this.shoppinglistsRepository,
  })  : assert(authenticationRepository != null),
        assert(itemsRepository != null),
        assert(shoppinglistsRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AuthenticationBloc(
              authenticationRepository: authenticationRepository,
            ),
          ),
          BlocProvider(
            create: (_) => ItemsBloc(
              itemsRepository: itemsRepository,
            ),
          ),
          BlocProvider(
            create: (_) => PersonalShoppinglistCubit(
              shoppinglistsRepository,
            ),
          ),
          BlocProvider(
            create: (_) => ShoppinglistCubit(
              shoppinglistsRepository,
            ),
          ),
          BlocProvider(
            create: (_) => ShoppinglistsBloc(
              shoppinglistsRepository: shoppinglistsRepository,
            ),
          ),
        ],
        child: ChangeNotifierProvider(
          create: (_) => ThemeProvider()..initializeTheme(),
          builder: (context, child) {
            final themeProvider = Provider.of<ThemeProvider>(context);

            return MaterialApp(
              title: 'Personal Shopper',
              debugShowCheckedModeBanner: false,
              navigatorKey: _navigatorKey,
              themeMode: themeProvider.themeMode,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              initialRoute: '/splashtwo',
              onGenerateRoute: AppRouter().onGenerateRoute,
            );
          },
        ),
      ),
    );
  }
}
