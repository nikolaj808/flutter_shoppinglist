import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shoppinglist/models/item_model.dart';
import 'package:flutter_shoppinglist/providers/repositories/items/items_repository.dart';

part 'items_event.dart';
part 'items_state.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  final ItemsRepository _itemsRepository;
  StreamSubscription _itemSubscription;

  ItemsBloc({@required ItemsRepository itemsRepository})
      : assert(itemsRepository != null),
        _itemsRepository = itemsRepository,
        super(ItemsInitial());

  @override
  Stream<ItemsState> mapEventToState(
    ItemsEvent event,
  ) async* {
    if (event is GetItems) {
      yield* _mapGetItemsToState(event);
    } else if (event is GetPersonalItems) {
      yield* _mapGetPersonalItemsToState();
    } else if (event is AddItem) {
      yield* _mapAddItemToState(event);
    } else if (event is UpdateItem) {
      yield* _mapUpdateItemToState(event);
    } else if (event is DeleteItem) {
      yield* _mapDeleteItemToState(event);
    } else if (event is ItemsUpdated) {
      yield* _mapItemsUpdatedToState(event);
    }
  }

  Stream<ItemsState> _mapGetItemsToState(GetItems event) async* {
    await _itemSubscription?.cancel();
    yield ItemsLoading();
    try {
      _itemSubscription = _itemsRepository
          .getItems(event.shoppinglistId)
          .listen((updatedItems) => add(ItemsUpdated(items: updatedItems)));
    } catch (_) {
      yield ItemsError();
    }
  }

  Stream<ItemsState> _mapGetPersonalItemsToState() async* {
    await _itemSubscription?.cancel();
    yield ItemsLoading();
    try {
      final _itemStream = await _itemsRepository.getPersonalItems();
      _itemSubscription = _itemStream
          .listen((updatedItems) => add(ItemsUpdated(items: updatedItems)));
    } catch (_) {
      yield ItemsError();
    }
  }

  Stream<ItemsState> _mapAddItemToState(AddItem event) async* {
    _itemsRepository.addItem(event.newItem);
  }

  Stream<ItemsState> _mapUpdateItemToState(UpdateItem event) async* {
    _itemsRepository.updateItem(event.updatedItem);
  }

  Stream<ItemsState> _mapDeleteItemToState(DeleteItem event) async* {
    _itemsRepository.deleteItem(event.itemToDelete);
  }

  Stream<ItemsState> _mapItemsUpdatedToState(ItemsUpdated event) async* {
    yield ItemsLoaded(items: event.items);
  }

  @override
  Future<void> close() async {
    await _itemSubscription?.cancel();
    return super.close();
  }
}
