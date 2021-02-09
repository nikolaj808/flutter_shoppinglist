import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shoppinglist/item_details/item_details_screen.dart';
import 'package:flutter_shoppinglist/models/item_model.dart';
import 'package:flutter_shoppinglist/personal_shoppinglist/cubit/personal_shoppinglist_cubit.dart';
import 'package:flutter_shoppinglist/providers/blocs/items/items_bloc.dart';
import 'package:flutter_shoppinglist/providers/repositories/authentication/authentication_repository.dart';
import 'package:flutter_shoppinglist/shared/create_item_fab.dart';
import 'package:flutter_shoppinglist/shared/items_error_widget.dart';
import 'package:flutter_shoppinglist/shared/items_loading_widget.dart';
import 'package:flutter_shoppinglist/shared/search_app_bar.dart';
import 'package:flutter_shoppinglist/shared/shopping_list_item.dart';
import 'package:flutter_shoppinglist/shared/side_menu_wrapper.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

class PersonalShoppinglistScreen extends StatefulWidget {
  @override
  _PersonalShoppinglistScreenState createState() =>
      _PersonalShoppinglistScreenState();
}

class _PersonalShoppinglistScreenState
    extends State<PersonalShoppinglistScreen> {
  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();
  final GlobalKey<FormState> _createItemFormKey = GlobalKey<FormState>();

  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();

  @override
  void initState() {
    BlocProvider.of<ItemsBloc>(context).add(
      GetPersonalItems(),
    );
    super.initState();
  }

  void _onCreateItem(BuildContext context, String name, int quantity) {
    final personalShoppinglistState =
        BlocProvider.of<PersonalShoppinglistCubit>(context).state
            as PersonalShoppinglistLoaded;

    final newItem = Item(
      name: name,
      quantity: quantity,
      createdAt: DateTime.now(),
      lastModifiedAt: DateTime.now(),
      userId: _authenticationRepository.getUserId(),
      shoppinglistId: personalShoppinglistState.personalShoppinglist.id,
    );

    BlocProvider.of<ItemsBloc>(context).add(AddItem(newItem: newItem));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalShoppinglistCubit, PersonalShoppinglistState>(
      builder: (context, state) => SideMenuWrapper(
        currentShoppinglistId: state is PersonalShoppinglistLoaded
            ? state.personalShoppinglist.id
            : '',
        sideMenuKey: _sideMenuKey,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          extendBodyBehindAppBar: true,
          floatingActionButton: state is PersonalShoppinglistLoaded
              ? CreateItemFab(
                  createItemFormKey: _createItemFormKey,
                  onCreateItem: _onCreateItem,
                )
              : null,
          appBar: SearchAppBar(
            sideMenuKey: _sideMenuKey,
            shoppinglistId: state is PersonalShoppinglistLoaded
            ? state.personalShoppinglist.id
            : '',
            isPersonalShoppinglist: true,
          ),
          body: GestureDetector(
            onTap: () {
              if (_sideMenuKey.currentState.isOpened) {
                _sideMenuKey.currentState.closeSideMenu();
              }
              FocusScope.of(context).unfocus();
            },
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.1,
                    ),
                    child: state is PersonalShoppinglistLoaded
                        ? Text(
                            state.personalShoppinglist.name,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          )
                        : const LinearProgressIndicator(),
                  ),
                  Divider(
                    indent: MediaQuery.of(context).size.width * 0.05,
                    endIndent: MediaQuery.of(context).size.width * 0.1,
                    thickness: 1.0,
                  ),
                  BlocBuilder<ItemsBloc, ItemsState>(
                    builder: (context, state) {
                      if (state is ItemsLoading) {
                        return ItemsLoadingWidget();
                      } else if (state is ItemsError) {
                        return ItemsErrorWidget();
                      } else if (state is ItemsLoaded) {
                        final items = state.items;

                        return Flexible(
                          child: ListView.builder(
                            itemCount: items.length,
                            itemBuilder: (_, index) => OpenContainer(
                              openBuilder: (_, __) =>
                                  ItemDetailsScreen(item: items[index]),
                              closedElevation: 0,
                              closedColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              closedBuilder: (_, __) =>
                                  ShoppingListItem(item: items[index]),
                            ),
                          ),
                        );
                      }

                      return ItemsLoadingWidget();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
