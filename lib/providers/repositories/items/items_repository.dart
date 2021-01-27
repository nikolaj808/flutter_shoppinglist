import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_shoppinglist/models/item_model.dart';

class ItemsRepository {
  final itemsCollection = FirebaseFirestore.instance.collection('items');

  Stream<List<Item>> getItems() {
    return itemsCollection.orderBy('createdAt').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Item.fromSnapshot(doc)).toList();
    });
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
