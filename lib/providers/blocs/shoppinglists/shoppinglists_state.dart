part of 'shoppinglists_bloc.dart';

abstract class ShoppinglistsState extends Equatable {
  const ShoppinglistsState();

  @override
  List<Object> get props => [];
}

class ShoppinglistsInitial extends ShoppinglistsState {}

class ShoppinglistsLoading extends ShoppinglistsState {}

class ShoppinglistsLoaded extends ShoppinglistsState {
  final List<Shoppinglist> shoppinglists;

  const ShoppinglistsLoaded({this.shoppinglists});

  @override
  String toString() => 'ShoppinglistsLoaded { shoppinglists: $shoppinglists }';

  @override
  List<Object> get props => [shoppinglists];
}

class ShoppinglistsError extends ShoppinglistsState {}
