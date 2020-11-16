import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shoppinglist/widgets/item-detail.widget.dart';

class Item extends StatelessWidget {
  final DocumentSnapshot document;

  const Item({Key key, this.document}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (context) => ItemDetail(document: document),
      ),
      child: Dismissible(
        key: Key(document.id),
        onDismissed: (_) async {
          await FirebaseFirestore.instance
              .collection('items')
              .doc(document.id)
              .delete();
        },
        child: Card(
          elevation: 2,
          child: ListTile(
            title: Text(
              document['name'],
              style: Theme.of(context).primaryTextTheme.headline6,
            ),
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: Center(
                child: Text(
                  'x${document['quantity']}',
                  style: Theme.of(context).primaryTextTheme.subtitle1,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
