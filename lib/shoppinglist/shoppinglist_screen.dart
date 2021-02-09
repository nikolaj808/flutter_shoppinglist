import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shoppinglist/item_details/item_details_screen.dart';
import 'package:flutter_shoppinglist/models/item_model.dart';
import 'package:flutter_shoppinglist/models/shoppinglist_model.dart';
import 'package:flutter_shoppinglist/providers/blocs/items/items_bloc.dart';
import 'package:flutter_shoppinglist/providers/repositories/authentication/authentication_repository.dart';
import 'package:flutter_shoppinglist/shared/create_item_fab.dart';
import 'package:flutter_shoppinglist/shared/items_error_widget.dart';
import 'package:flutter_shoppinglist/shared/items_loading_widget.dart';
import 'package:flutter_shoppinglist/shared/search_app_bar.dart';
import 'package:flutter_shoppinglist/shared/shopping_list_item.dart';
import 'package:flutter_shoppinglist/shared/side_menu_wrapper.dart';
import 'package:flutter_shoppinglist/shoppinglist/cubit/shoppinglist_cubit.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

class ShoppinglistScreen extends StatefulWidget {
  final String shoppinglistId;

  const ShoppinglistScreen({
    Key key,
    @required this.shoppinglistId,
  }) : super(key: key);

  @override
  _ShoppinglistScreenState createState() => _ShoppinglistScreenState();
}

class _ShoppinglistScreenState extends State<ShoppinglistScreen> {
  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();
  final GlobalKey<FormState> _createItemFormKey = GlobalKey<FormState>();

  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();

  String shoppinglistId;
  Shoppinglist shoppinglist;

  @override
  void initState() {
    super.initState();
    shoppinglistId = widget.shoppinglistId;
    BlocProvider.of<ShoppinglistCubit>(context).getShoppinglist(
      shoppinglistId,
    );
  }

  void _onCreateItem(BuildContext context, String name, int quantity) {
    final newItem = Item(
      name: name,
      quantity: quantity,
      createdAt: DateTime.now(),
      lastModifiedAt: DateTime.now(),
      userId: _authenticationRepository.getUserId(),
      shoppinglistId: shoppinglist.id,
    );

    BlocProvider.of<ItemsBloc>(context).add(AddItem(newItem: newItem));
  }

  @override
  Widget build(BuildContext context) {
    return SideMenuWrapper(
      currentShoppinglistId: shoppinglist?.id ?? '',
      sideMenuKey: _sideMenuKey,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        floatingActionButton: CreateItemFab(
          createItemFormKey: _createItemFormKey,
          onCreateItem: _onCreateItem,
        ),
        appBar: SearchAppBar(sideMenuKey: _sideMenuKey, shoppinglistId: widget.shoppinglistId),
        body: BlocListener<ShoppinglistCubit, ShoppinglistState>(
          listener: (context, state) {
            if (state is ShoppinglistLoaded) {
              setState(() => shoppinglist = state.shoppinglist);

              BlocProvider.of<ItemsBloc>(context).add(
                GetItems(shoppinglistId: state.shoppinglist.id),
              );
            }
          },
          child: GestureDetector(
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
                    child: shoppinglist?.name != null
                        ? Text(
                            shoppinglist.name,
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
