import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shoppinglist/models/shoppinglist_model.dart';
import 'package:flutter_shoppinglist/providers/repositories/shoppinglists/shoppinglists_repository.dart';

part 'shoppinglist_state.dart';

class ShoppinglistCubit extends Cubit<ShoppinglistState> {
  final ShoppinglistsRepository _shoppinglistsRepository;
  StreamSubscription _shoppinglistSubscription;

  ShoppinglistCubit(this._shoppinglistsRepository)
      : assert(_shoppinglistsRepository != null),
        super(ShoppinglistInitial());

  Future<void> getShoppinglist(String shoppinglistId) async {
    _shoppinglistSubscription?.cancel();
    emit(ShoppinglistLoading());
    try {
      _shoppinglistSubscription = _shoppinglistsRepository
          .getShoppinglist(shoppinglistId)
          .listen((updatedList) {
        emit(ShoppinglistLoading());
        emit(ShoppinglistLoaded(shoppinglist: updatedList));
      });
    } catch (_) {
      emit(ShoppinglistError());
    }
  }

  @override
  Future<void> close() {
    _shoppinglistSubscription?.cancel();
    return super.close();
  }
}
