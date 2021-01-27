import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shoppinglist/home/widgets/items_error_widget.dart';
import 'package:flutter_shoppinglist/home/widgets/items_loading_widget.dart';
import 'package:flutter_shoppinglist/home/widgets/shopping_list_item.dart';
import 'package:flutter_shoppinglist/item_details/item_details_screen.dart';
import 'package:flutter_shoppinglist/providers/blocs/items/items_bloc.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

class HomeScreenBody extends StatelessWidget {
  final GlobalKey<SideMenuState> sideMenuKey;

  const HomeScreenBody({
    Key key,
    @required this.sideMenuKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (sideMenuKey.currentState.isOpened) {
          sideMenuKey.currentState.closeSideMenu();
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
              child: Text(
                'Bøllehatten 9',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
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
                        closedColor: Theme.of(context).scaffoldBackgroundColor,
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
    );
  }
}
