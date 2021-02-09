import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_shoppinglist/models/app_user_model.dart';
import 'package:flutter_shoppinglist/providers/repositories/authentication/exceptions/authentication_exception.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationRepository {
  final usersCollection = FirebaseFirestore.instance.collection('users');

  AuthenticationRepository({
    firebase_auth.FirebaseAuth firebaseAuth,
    GoogleSignIn googleSignIn,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  /// Stream of [User] which will emit the current user when
  /// the authentication state changes.
  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser;
    });
  }

  /// Starts the Sign In with Google Flow.
  ///
  /// Throws a [LogInWithGoogleFailure] if an exception occurs.
  Future<void> logInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser.authentication;
      final credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _firebaseAuth.signInWithCredential(credential);
      await saveUser();
    } on Exception {
      throw LogInWithGoogleFailure();
    }
  }

  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } on Exception {
      throw LogOutFailure();
    }
  }

  Future<void> saveUser() async {
    final User user = getUser();

    final userAlreadySaved = await usersCollection
        .where(
          'uid',
          isEqualTo: user.uid,
        )
        .get();

    if (userAlreadySaved.docs.isEmpty) {
      final AppUser appUser = AppUser.fromFirebaseUser(user);
      return usersCollection.add(appUser.toDocument());
    }
  }

  /// Checks if there is a current user -
  /// returns [false] if there is none, returns [true] if there is one
  bool isAuthenticated() => _firebaseAuth?.currentUser != null;

  /// Gets the currently logged in users ID
  String getUserId() => _firebaseAuth?.currentUser?.uid;

  User getUser() => _firebaseAuth?.currentUser;
}
