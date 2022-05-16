// ignore_for_file: prefer_final_fields

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:universe_history_app/core/api.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
  final Api api = Api();

  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  bool isLoading = true;
  String? token;

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

  getUser() {
    user = auth.currentUser;
    notifyListeners();
  }

  getToken() async {
    await api
        .getToken()
        .then((String result) => {
              token = result,
            })
        .catchError((error) => debugPrint('ERROR:' + error));
  }

  registerAuthentication(String email, String senha) async {
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: senha);
      await getUser();
      await getToken();
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
      await getUser();
      await getToken();
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
    getUser();
  }

  delete() async {
    var _user = auth.currentUser;
    _user!.delete();
    getUser();
  }
}
