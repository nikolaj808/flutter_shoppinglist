import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shoppinglist/models/shoppinglist_model.dart';
import 'package:flutter_shoppinglist/providers/repositories/shoppinglists/shoppinglists_repository.dart';

part 'shoppinglist_event.dart';
part 'shoppinglist_state.dart';

class ShoppinglistBloc extends Bloc<ShoppinglistEvent, ShoppinglistState> {
  final ShoppinglistsRepository _shoppinglistsRepository;

  ShoppinglistBloc({@required ShoppinglistsRepository shoppinglistsRepository})
      : assert(shoppinglistsRepository != null),
        _shoppinglistsRepository = shoppinglistsRepository,
        super(ShoppinglistInitial());

  @override
  Stream<ShoppinglistState> mapEventToState(
    ShoppinglistEvent event,
  ) async* {
    if (event is GetShoppinglists) {
      yield* _mapGetShoppinglistsToState();
    } else if (event is AddShoppinglist) {
      yield* _mapAddShoppinglistToState(event);
    } else if (event is UpdateShoppinglist) {
      yield* _mapUpdateShoppinglistToState(event);
    } else if (event is DeleteShoppinglist) {
      yield* _mapDeleteShoppinglistToState(event);
    } else if (event is ShoppinglistsUpdated) {
      yield* _mapShoppinglistsUpdatedToState(event);
    }
  }

  Stream<ShoppinglistState> _mapGetShoppinglistsToState() async* {
    final shoppinglistsStream = _shoppinglistsRepository.getShoppinglists();
    add(ShoppinglistsUpdated(shoppinglists: shoppinglistsStream));
  }

  Stream<ShoppinglistState> _mapAddShoppinglistToState(
      AddShoppinglist event) async* {
    _shoppinglistsRepository.createShoppinglist(event.newShoppinglist);
  }

  Stream<ShoppinglistState> _mapUpdateShoppinglistToState(
      UpdateShoppinglist event) async* {
    // TODO: Add handler
  }

  Stream<ShoppinglistState> _mapDeleteShoppinglistToState(
      DeleteShoppinglist event) async* {
    // TODO: Add handler
  }

  Stream<ShoppinglistState> _mapShoppinglistsUpdatedToState(
      ShoppinglistsUpdated event) async* {
    yield ShoppinglistsLoaded(shoppinglists: event.shoppinglists);
  }
}
