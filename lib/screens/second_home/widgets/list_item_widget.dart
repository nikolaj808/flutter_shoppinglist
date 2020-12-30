import 'package:flutter/material.dart';

class ListItemWidget extends StatelessWidget {
  final String id;
  final String name;
  final int quantity;
  final void Function(DismissDirection) onDismissed;
  final Future<void> Function() onIncreaseQuantity;
  final Future<void> Function() onDecreaseQuantity;

  const ListItemWidget({
    Key key,
    @required this.id,
    @required this.name,
    @required this.quantity,
    @required this.onDismissed,
    @required this.onIncreaseQuantity,
    @required this.onDecreaseQuantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(id),
      onDismissed: onDismissed,
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: ListTile(
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () async => await onIncreaseQuantity(),
                    child: Icon(
                      Icons.arrow_upward,
                      color: Theme.of(context).accentIconTheme.color,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async => await onDecreaseQuantity(),
                    child: Icon(
                      Icons.arrow_downward,
                      color: Theme.of(context).accentIconTheme.color,
                    ),
                  ),
                ],
              ),
              title: Text(
                name,
                style: Theme.of(context).textTheme.headline6,
              ),
              trailing: CircleAvatar(
                child: Text(
                  'x$quantity',
                  style: TextStyle(
                    color: Theme.of(context).primaryIconTheme.color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: Theme.of(context).primaryColor,
              ),
              tileColor: Theme.of(context).accentColor,
              contentPadding: EdgeInsets.all(8.0),
            ),
          ),
        ),
      ),
    );
  }
}
