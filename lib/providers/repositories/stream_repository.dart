import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_shoppinglist/models/item_model.dart';

class StreamRepository {
  final itemsCollection = FirebaseFirestore.instance.collection('tests');

  Stream<QuerySnapshot> getItems() {
    return itemsCollection.snapshots();
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
