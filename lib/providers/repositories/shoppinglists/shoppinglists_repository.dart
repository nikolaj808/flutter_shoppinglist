import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_shoppinglist/models/shoppinglist_model.dart';
import 'package:flutter_shoppinglist/providers/repositories/authentication/authentication_repository.dart';

class ShoppinglistsRepository {
  final shoppinglistsCollection =
      FirebaseFirestore.instance.collection('shoppinglists');

  Stream<List<Shoppinglist>> getShoppinglists() {
    return shoppinglistsCollection.orderBy('name').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Shoppinglist.fromSnapshot(doc))
          .toList();
    });
  }

  Future<void> createShoppinglist(Shoppinglist shoppinglist) async {
    final userId = AuthenticationRepository().getUserId();
    final newShoppinglist =
        await shoppinglistsCollection.add(shoppinglist.toDocument());
    shoppinglistsCollection
        .doc(newShoppinglist.id)
        .collection('sharedWith')
        .add({userId: userId});
  }

  Future<void> addUserToShoppinglist(Shoppinglist shoppinglist, String userId) {
    return shoppinglistsCollection
        .doc(shoppinglist.id)
        .collection('sharedWith')
        .add({userId: userId});
  }
}
