part of 'shoppinglist_bloc.dart';

abstract class ShoppinglistState extends Equatable {
  const ShoppinglistState();

  @override
  List<Object> get props => [];
}

class ShoppinglistInitial extends ShoppinglistState {}

class ShoppinglistsLoading extends ShoppinglistState {}

class ShoppinglistsLoaded extends ShoppinglistState {
  final Stream<List<Shoppinglist>> shoppinglists;

  const ShoppinglistsLoaded({this.shoppinglists});

  @override
  String toString() => 'ShoppinglistsLoaded { shoppinglists: $shoppinglists }';

  @override
  List<Object> get props => [shoppinglists];
}

class ShoppinglistsError extends ShoppinglistState {}
