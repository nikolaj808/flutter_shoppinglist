import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shoppinglist/models/shoppinglist_model.dart';
import 'package:flutter_shoppinglist/providers/repositories/shoppinglists/shoppinglists_repository.dart';

part 'shoppinglists_event.dart';
part 'shoppinglists_state.dart';

class ShoppinglistsBloc extends Bloc<ShoppinglistsEvent, ShoppinglistsState> {
  final ShoppinglistsRepository _shoppinglistsRepository;
  StreamSubscription _shoppinglistsSubscription;

  ShoppinglistsBloc({@required ShoppinglistsRepository shoppinglistsRepository})
      : assert(shoppinglistsRepository != null),
        _shoppinglistsRepository = shoppinglistsRepository,
        super(ShoppinglistsInitial());

  @override
  Stream<ShoppinglistsState> mapEventToState(
    ShoppinglistsEvent event,
  ) async* {
    if (event is GetShoppinglists) {
      yield* _mapGetShoppinglistsToState();
    } else if (event is AddShoppinglist) {
      yield* _mapAddShoppinglistToState(event);
    } else if (event is ShoppinglistsUpdated) {
      yield* _mapShoppinglistsUpdatedToState(event);
    }
  }

  Stream<ShoppinglistsState> _mapGetShoppinglistsToState() async* {
    await _shoppinglistsSubscription?.cancel();
    yield ShoppinglistsLoading();
    try {
      _shoppinglistsSubscription = _shoppinglistsRepository
          .getShoppinglists()
          .listen((updatedlists) => add(
                ShoppinglistsUpdated(shoppinglists: updatedlists),
              ));
    } catch (_) {
      yield ShoppinglistsError();
    }
  }

  Stream<ShoppinglistsState> _mapAddShoppinglistToState(
      AddShoppinglist event) async* {
    _shoppinglistsRepository.createShoppinglist(event.newShoppinglist);
  }

  Stream<ShoppinglistsState> _mapShoppinglistsUpdatedToState(
      ShoppinglistsUpdated event) async* {
    yield ShoppinglistsLoaded(shoppinglists: event.shoppinglists);
  }

  @override
  Future<void> close() async {
    await _shoppinglistsSubscription?.cancel();
    return super.close();
  }
}
