import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:meta/meta.dart';

import '../model/user.dart';

class SignUpFailure implements Exception {}

class SignInFailure implements Exception {}

class LogOutFailure implements Exception {}

class AuthenticationRepository {
  AuthenticationRepository({
    firebase_auth.FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  final firebase_auth.FirebaseAuth _firebaseAuth;

  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser == null ? User.empty : firebaseUser.toUser;
    });
  }

  Future<User> signUp({
    @required String email,
    @required String password,
  }) async {
    assert(email != null && password != null);
    try {
      final _user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _user.user.toUser;
    } on Exception {
      throw SignUpFailure();
    }
  }

  Future<User> signIn({
    @required String email,
    @required String password,
  }) async {
    assert(email != null && password != null);
    try {
      final _user = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      print(_user.user.email);
      return _user.user.toUser;
    } on Exception {
      throw SignInFailure();
    }
  }

  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
      ]);
    } on Exception {
      throw LogOutFailure();
    }
  }
}

extension on firebase_auth.User {
  User get toUser {
    return User(id: uid, email: email);
  }
}
