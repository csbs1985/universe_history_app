// ignore_for_file: prefer_final_fields

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  bool isLoading = true;

  AuthService() {
    _authCheck();
  }

  _authCheck() {
    auth.authStateChanges().listen((User? user) {
      user = (user == null) ? null : user;
      isLoading = false;
      notifyListeners();
    });
  }

  _getUser() {
    user = auth.currentUser;
    notifyListeners();
  }

  registerAuthentication(String email, String senha) async {
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: senha);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthException('a senha é muito fraca');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException('este email já está cadastrado');
      }
    }
  }

  loginAuthentication(String email, String senha) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: senha);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException('email não encontrado. Cadastre-se.');
      } else if (e.code == 'wrong-password') {
        throw AuthException('senha incorreta. Tente novamente');
      }
    }
  }

  logout() async {
    await auth.signOut();
    _getUser();
  }

  delete() async {
    var _user = auth.currentUser;
    _user!.delete();

    _getUser();
  }
}
