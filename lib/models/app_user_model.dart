import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppUser {
  final String uid;
  final String displayName;
  final String email;
  final String photoURL;

  AppUser({
    @required this.uid,
    @required this.displayName,
    @required this.email,
    @required this.photoURL,
  });

  AppUser copyWith({
    String uid,
    String displayName,
    String email,
    String photoURL,
  }) {
    return AppUser(
      uid: uid ?? this.uid,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      photoURL: photoURL ?? this.photoURL,
    );
  }

  factory AppUser.fromFirebaseUser(User user) {
    return AppUser(
      uid: user.uid,
      displayName: user.displayName,
      email: user.email,
      photoURL: user.photoURL,
    );
  }

  Map<String, Object> toDocument() {
    return {
      'uid': uid,
      'displayName': displayName,
      'email': email,
      'photoURL': photoURL,
    };
  }
}
