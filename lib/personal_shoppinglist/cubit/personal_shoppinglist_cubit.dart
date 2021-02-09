import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shoppinglist/models/shoppinglist_model.dart';
import 'package:flutter_shoppinglist/providers/repositories/shoppinglists/shoppinglists_repository.dart';

part 'personal_shoppinglist_state.dart';

class PersonalShoppinglistCubit extends Cubit<PersonalShoppinglistState> {
  final ShoppinglistsRepository _shoppinglistsRepository;
  StreamSubscription personalShoppinglistSubscription;

  PersonalShoppinglistCubit(this._shoppinglistsRepository)
      : assert(_shoppinglistsRepository != null),
        super(PersonalShoppinglistInitial());

  Future<void> getPersonalShoppinglist() async {
    await personalShoppinglistSubscription?.cancel();
    emit(PersonalShoppinglistLoading());
    try {
      final personalShoppinglistStream =
          await _shoppinglistsRepository.getPersonalShoppinglistStream();
      personalShoppinglistSubscription =
          personalShoppinglistStream.listen((updatedPersonalShoppinglist) {
        emit(PersonalShoppinglistLoading());
        emit(PersonalShoppinglistLoaded(
          personalShoppinglist: updatedPersonalShoppinglist,
        ));
      });
    } catch (_) {
      emit(PersonalShoppinglistError());
    }
  }
}
