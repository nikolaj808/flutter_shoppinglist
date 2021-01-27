import 'package:flutter/material.dart';
import 'package:flutter_shoppinglist/item_details/widgets/detail_section.dart';
import 'package:flutter_shoppinglist/models/item_model.dart';
import 'package:jiffy/jiffy.dart';

class ItemDetailsScreen extends StatelessWidget {
  final Item item;

  const ItemDetailsScreen({
    Key key,
    @required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Vare detaljer',
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: Column(
          children: [
            DetailSection(title: 'Vare navn', body: item.name),
            DetailSection(title: 'Vare antal', body: item.quantity.toString()),
            DetailSection(
              title: 'Oprettet',
              body: Jiffy(item.createdAt).format('dd-MM-yyyy kk:mm'),
            ),
            DetailSection(
              title: 'Sidst redigeret',
              body: Jiffy(item.lastModifiedAt).format('dd-MM-yyyy kk:mm'),
            ),
            DetailSection(
              title: 'Oprettet af',
              body: item.userId,
            ),
          ],
        ),
      ),
    );
  }
}
