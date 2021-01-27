import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shoppinglist/create_item/create_item_screen.dart';

class HomeScreenFab extends StatelessWidget {
  final GlobalKey<FormState> createItemFormKey;
  final void Function(BuildContext context, String name, int quantity)
      onCreateItem;

  const HomeScreenFab({
    Key key,
    @required this.createItemFormKey,
    @required this.onCreateItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      transitionDuration: const Duration(milliseconds: 400),
      transitionType: ContainerTransitionType.fadeThrough,
      openBuilder: (context, _) => CreateItemScreen(
        createItemFormKey: createItemFormKey,
        onCreateItem: onCreateItem,
      ),
      closedElevation: 6.0,
      openColor: Theme.of(context).scaffoldBackgroundColor,
      closedColor: Theme.of(context).accentColor,
      closedShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(64 / 2),
        ),
      ),
      closedBuilder: (context, _) => SizedBox(
        height: 64,
        width: 64,
        child: Container(
          color: Theme.of(context).accentColor,
          child: const Center(
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
