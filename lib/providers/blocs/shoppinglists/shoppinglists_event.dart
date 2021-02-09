part of 'shoppinglists_bloc.dart';

abstract class ShoppinglistsEvent extends Equatable {
  const ShoppinglistsEvent();

  @override
  List<Object> get props => [];
}

class GetShoppinglists extends ShoppinglistsEvent {}

class AddShoppinglist extends ShoppinglistsEvent {
  final Shoppinglist newShoppinglist;

  const AddShoppinglist({@required this.newShoppinglist});

  @override
  String toString() => 'AddShoppinglist { newShoppinglist: $newShoppinglist }';

  @override
  List<Object> get props => [newShoppinglist];
}

class UpdateShoppinglist extends ShoppinglistsEvent {}

class DeleteShoppinglist extends ShoppinglistsEvent {}

class ShoppinglistsUpdated extends ShoppinglistsEvent {
  final List<Shoppinglist> shoppinglists;

  const ShoppinglistsUpdated({@required this.shoppinglists});

  @override
  List<Object> get props => [shoppinglists];
}
