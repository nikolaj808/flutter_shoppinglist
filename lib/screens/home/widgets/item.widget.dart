import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shoppinglist/screens/home/widgets/item-detail.widget.dart';

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
          margin: const EdgeInsets.only(
            left: 32.0,
            right: 32.0,
            bottom: 16.0,
          ),
          elevation: 2,
          child: ListTile(
            title: Text(
              document['name'],
              style: Theme.of(context).primaryTextTheme.headline6,
            ),
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).accentColor,
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
