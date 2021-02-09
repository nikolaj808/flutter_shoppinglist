import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_shoppinglist/models/item_model.dart';
import 'package:flutter_shoppinglist/providers/repositories/shoppinglists/shoppinglists_repository.dart';

class ItemsRepository {
  final itemsCollection = FirebaseFirestore.instance.collection('items');

  Stream<List<Item>> getItems(String shoppinglistId) {
    return itemsCollection
        .where('shoppinglistId', isEqualTo: shoppinglistId)
        .orderBy('createdAt')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Item.fromSnapshot(doc)).toList());
  }

  Future<Stream<List<Item>>> getPersonalItems() async {
    final ShoppinglistsRepository _shoppinglistsRepository =
        ShoppinglistsRepository();
    final personalShoppinglist =
        await _shoppinglistsRepository.getPersonalShoppinglist();

    return itemsCollection
        .where('shoppinglistId', isEqualTo: personalShoppinglist.id)
        .orderBy('createdAt')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Item.fromSnapshot(doc)).toList());
  }

  Future<void> addItem(Item item) {
    return itemsCollection.add(item.toDocument());
  }

  Future<void> updateItem(Item item) {
    return itemsCollection.doc(item.id).update(item.toDocument());
  }

  Future<void> deleteItem(Item item) {
    return itemsCollection.doc(item.id).delete();
  }
}
