part of 'shoppinglist_bloc.dart';

abstract class ShoppinglistEvent extends Equatable {
  const ShoppinglistEvent();

  @override
  List<Object> get props => [];
}

class GetShoppinglists extends ShoppinglistEvent {}

class AddShoppinglist extends ShoppinglistEvent {
  final Shoppinglist newShoppinglist;

  const AddShoppinglist({@required this.newShoppinglist});

  @override
  String toString() => 'AddShoppinglist { newShoppinglist: $newShoppinglist }';

  @override
  List<Object> get props => [newShoppinglist];
}

class UpdateShoppinglist extends ShoppinglistEvent {
  final Shoppinglist updatedShoppinglist;

  const UpdateShoppinglist(this.updatedShoppinglist);

  @override
  String toString() =>
      'UpdateShoppinglist { updatedShoppinglist: $updatedShoppinglist }';

  @override
  List<Object> get props => [updatedShoppinglist];
}

class DeleteShoppinglist extends ShoppinglistEvent {
  final Shoppinglist shoppinglistToDelete;

  const DeleteShoppinglist(this.shoppinglistToDelete);

  @override
  String toString() =>
      'DeleteShoppinglist { shoppinglistToDelete: $shoppinglistToDelete }';

  @override
  List<Object> get props => [shoppinglistToDelete];
}

class ShoppinglistsUpdated extends ShoppinglistEvent {
  final Stream<List<Shoppinglist>> shoppinglists;

  const ShoppinglistsUpdated({@required this.shoppinglists});

  @override
  List<Object> get props => [shoppinglists];
}
