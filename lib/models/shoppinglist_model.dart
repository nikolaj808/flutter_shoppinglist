import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Shoppinglist {
  final String id;
  final String name;
  final String ownerId;
  final List<String> userIds;
  final DateTime createdAt;
  final DateTime lastModifiedAt;

  Shoppinglist({
    this.id,
    @required this.name,
    @required this.ownerId,
    @required this.userIds,
    @required this.createdAt,
    @required this.lastModifiedAt,
  });

  Shoppinglist copyWith(
    String id,
    String name,
    String ownerId,
    List<String> userIds,
    DateTime createdAt,
    DateTime lastModifiedAt,
  ) {
    return Shoppinglist(
      id: id ?? this.id,
      name: name ?? this.name,
      ownerId: ownerId ?? this.ownerId,
      userIds: userIds ?? this.userIds,
      createdAt: createdAt ?? this.createdAt,
      lastModifiedAt: lastModifiedAt ?? this.lastModifiedAt,
    );
  }

  factory Shoppinglist.fromSnapshot(QueryDocumentSnapshot snapshot) {
    return Shoppinglist(
      id: snapshot.id,
      name: snapshot.data()['name'] as String,
      ownerId: snapshot.data()['ownerId'] as String,
      userIds: snapshot.data()['userIds'] as List<String>,
      createdAt: DateTime.parse(snapshot.data()['createdAt'] as String),
      lastModifiedAt:
          DateTime.parse(snapshot.data()['lastModifiedAt'] as String),
    );
  }

  Map<String, Object> toDocument() {
    return {
      'name': name,
      'ownerId': ownerId,
      'userIds': userIds,
      'createdAt': createdAt.toIso8601String(),
      'lastModifiedAt': lastModifiedAt.toIso8601String(),
    };
  }
}
