import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shoppinglist/models/item_model.dart';
import 'package:flutter_shoppinglist/providers/blocs/items/items_bloc.dart';
import 'package:jiffy/jiffy.dart';

class ShoppingListItem extends StatelessWidget {
  final Item item;

  const ShoppingListItem({
    Key key,
    @required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(item.id),
      background: Container(
        color: Theme.of(context).errorColor,
      ),
      onDismissed: (_) {
        BlocProvider.of<ItemsBloc>(context).add(DeleteItem(itemToDelete: item));
      },
      child: ListTile(
        // onTap: () {},
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Theme.of(context).primaryTextTheme.bodyText1.color,
          child: Text('x${item.quantity}'),
        ),
        title: Text(
          item.name,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        subtitle: Text(
          'Tilføjet af: ${item.userId}',
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.caption,
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              Jiffy(item.createdAt).format('dd/MM/yy'),
              style: Theme.of(context).textTheme.caption,
            ),
            Text(
              Jiffy(item.createdAt).Hm,
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      ),
    );
  }
}
