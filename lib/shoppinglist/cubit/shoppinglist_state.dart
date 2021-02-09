part of 'shoppinglist_cubit.dart';

abstract class ShoppinglistState extends Equatable {
  const ShoppinglistState();

  @override
  List<Object> get props => [];
}

class ShoppinglistInitial extends ShoppinglistState {}

class ShoppinglistLoading extends ShoppinglistState {}

class ShoppinglistLoaded extends ShoppinglistState {
  final Shoppinglist shoppinglist;

  const ShoppinglistLoaded({
    @required this.shoppinglist,
  });

  @override
  List<Object> get props => [shoppinglist];
}

class ShoppinglistError extends ShoppinglistState {}
