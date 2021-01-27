import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Item {
  final String id;
  final String name;
  final int quantity;
  final DateTime createdAt;
  final DateTime lastModifiedAt;
  final String userId;
  final String shoppinglistId;

  Item({
    this.id,
    @required this.name,
    @required this.quantity,
    @required this.createdAt,
    @required this.lastModifiedAt,
    @required this.userId,
    @required this.shoppinglistId,
  });

  Item copyWith({
    String id,
    String name,
    int quantity,
    DateTime createdAt,
    DateTime lastModifiedAt,
    String userId,
    String shoppinglistId,
  }) {
    return Item(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      createdAt: createdAt ?? this.createdAt,
      lastModifiedAt: lastModifiedAt ?? this.lastModifiedAt,
      userId: userId ?? this.userId,
      shoppinglistId: shoppinglistId ?? this.shoppinglistId,
    );
  }

  factory Item.fromSnapshot(QueryDocumentSnapshot snapshot) {
    return Item(
      id: snapshot.id,
      name: snapshot.data()['name'] as String,
      quantity: snapshot.data()['quantity'] as int,
      createdAt: DateTime.parse(snapshot.data()['createdAt'] as String),
      lastModifiedAt:
          DateTime.parse(snapshot.data()['lastModifiedAt'] as String),
      userId: snapshot.data()['userId'] as String,
      shoppinglistId: snapshot.data()['shoppinglistId'] as String,
    );
  }

  Map<String, Object> toDocument() {
    return {
      'name': name,
      'quantity': quantity,
      'createdAt': createdAt.toIso8601String(),
      'lastModifiedAt': lastModifiedAt.toIso8601String(),
      'userId': userId,
      'shoppinglistId': shoppinglistId,
    };
  }
}
