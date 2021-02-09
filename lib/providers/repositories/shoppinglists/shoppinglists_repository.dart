import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_shoppinglist/models/shoppinglist_model.dart';
import 'package:flutter_shoppinglist/providers/repositories/authentication/authentication_repository.dart';

class ShoppinglistsRepository {
  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();
  final personalShoppinglistsCollection =
      FirebaseFirestore.instance.collection('personalShoppinglists');
  final shoppinglistsCollection =
      FirebaseFirestore.instance.collection('shoppinglists');

  Future<Stream<Shoppinglist>> getPersonalShoppinglistStream() async {
    final userId = _authenticationRepository.getUserId();
    final personalShoppinglistSnapshot = await personalShoppinglistsCollection
        .where('ownerId', isEqualTo: userId)
        .get();

    if (personalShoppinglistSnapshot.docs.length != 1) {
      await createPersonalShoppinglist();
    }

    return personalShoppinglistsCollection
        .where('ownerId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => Shoppinglist.fromSnapshot(snapshot.docs.first));
  }

  Future<Shoppinglist> getPersonalShoppinglist() async {
    final userId = _authenticationRepository.getUserId();
    final personalShoppinglistSnapshot = await personalShoppinglistsCollection
        .where('ownerId', isEqualTo: userId)
        .get();

    if (personalShoppinglistSnapshot.docs.length != 1) {
      return createPersonalShoppinglist();
    }

    return Shoppinglist.fromSnapshot(personalShoppinglistSnapshot.docs.first);
  }

  Future<Shoppinglist> createPersonalShoppinglist() async {
    final userId = _authenticationRepository.getUserId();

    final Shoppinglist shoppinglist = Shoppinglist(
      name: 'Din indkøbsliste',
      ownerId: userId,
      createdAt: DateTime.now(),
      lastModifiedAt: DateTime.now(),
    );

    final newShoppinglistReference =
        await personalShoppinglistsCollection.add(shoppinglist.toDocument());
    final newShoppinglistSnapshot = await newShoppinglistReference.get();

    return Shoppinglist.fromSnapshot(newShoppinglistSnapshot);
  }

  Stream<List<Shoppinglist>> getShoppinglists() {
    return shoppinglistsCollection
        .orderBy('createdAt')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Shoppinglist.fromSnapshot(doc))
          .toList();
    });
  }

  Stream<Shoppinglist> getShoppinglist(String shoppinglistId) {
    return shoppinglistsCollection
        .doc(shoppinglistId)
        .snapshots()
        .map((snapshot) => Shoppinglist.fromSnapshot(snapshot));
  }

  Future<bool> shoppinglistExists(String shoppinglistId) async {
    final list = await shoppinglistsCollection.doc(shoppinglistId).get();
    return list.exists;
  }

  Future<void> createShoppinglist(Shoppinglist shoppinglist) async {
    final userId = _authenticationRepository.getUserId();
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
