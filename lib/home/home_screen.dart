import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shoppinglist/home/widgets/home_screen_body.dart';
import 'package:flutter_shoppinglist/home/widgets/home_screen_fab.dart';
import 'package:flutter_shoppinglist/home/widgets/search_app_bar.dart';
import 'package:flutter_shoppinglist/home/widgets/home_screen_side_menu_wrapper.dart';
import 'package:flutter_shoppinglist/models/item_model.dart';
import 'package:flutter_shoppinglist/providers/blocs/items/items_bloc.dart';
import 'package:flutter_shoppinglist/providers/repositories/authentication/authentication_repository.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();
  final GlobalKey<FormState> _createItemFormKey = GlobalKey<FormState>();

  void _onCreateItem(BuildContext context, String name, int quantity) {
    final newItem = Item(
      name: name,
      quantity: quantity,
      createdAt: DateTime.now(),
      lastModifiedAt: DateTime.now(),
      userId: AuthenticationRepository().getUserId(),
      shoppinglistId: '1',
    );
    BlocProvider.of<ItemsBloc>(context).add(AddItem(newItem: newItem));
  }

  @override
  Widget build(BuildContext context) {
    return HomeScreenSideMenuWrapper(
      sideMenuKey: _sideMenuKey,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        floatingActionButton: HomeScreenFab(
          createItemFormKey: _createItemFormKey,
          onCreateItem: _onCreateItem,
        ),
        appBar: SearchAppBar(sideMenuKey: _sideMenuKey),
        body: HomeScreenBody(sideMenuKey: _sideMenuKey),
      ),
    );
  }
}
