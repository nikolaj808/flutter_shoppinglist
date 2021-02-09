part of 'personal_shoppinglist_cubit.dart';

abstract class PersonalShoppinglistState extends Equatable {
  const PersonalShoppinglistState();

  @override
  List<Object> get props => [];
}

class PersonalShoppinglistInitial extends PersonalShoppinglistState {}

class PersonalShoppinglistLoading extends PersonalShoppinglistState {}

class PersonalShoppinglistLoaded extends PersonalShoppinglistState {
  final Shoppinglist personalShoppinglist;

  const PersonalShoppinglistLoaded({
    @required this.personalShoppinglist,
  });

  @override
  List<Object> get props => [personalShoppinglist];
}

class PersonalShoppinglistError extends PersonalShoppinglistState {}
