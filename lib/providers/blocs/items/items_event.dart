part of 'items_bloc.dart';

abstract class ItemsEvent extends Equatable {
  const ItemsEvent();

  @override
  List<Object> get props => [];
}

class GetItems extends ItemsEvent {
  final String shoppinglistId;

  const GetItems({@required this.shoppinglistId});

  @override
  List<Object> get props => [shoppinglistId];
}

class GetPersonalItems extends ItemsEvent {}

class AddItem extends ItemsEvent {
  final Item newItem;

  const AddItem({@required this.newItem});

  @override
  String toString() => 'AddItem { newItem: $newItem }';

  @override
  List<Object> get props => [newItem];
}

class UpdateItem extends ItemsEvent {
  final Item updatedItem;

  const UpdateItem({@required this.updatedItem});

  @override
  String toString() => 'UpdateItem { updatedItem: $updatedItem }';

  @override
  List<Object> get props => [updatedItem];
}

class DeleteItem extends ItemsEvent {
  final Item itemToDelete;

  const DeleteItem({@required this.itemToDelete});

  @override
  String toString() => 'DeleteItem { itemToDelete: $itemToDelete }';

  @override
  List<Object> get props => [itemToDelete];
}

class ItemsUpdated extends ItemsEvent {
  final List<Item> items;

  const ItemsUpdated({@required this.items});

  @override
  List<Object> get props => [items];
}
