import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/models/user_model.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
  final Api api = Api();

  FirebaseAuth auth = FirebaseAuth.instance;

  User? user;
  String? token;
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

  getUser() {
    user = auth.currentUser;
    notifyListeners();
  }

  logout() async {
    await auth.signOut();
    getUser();
  }

  delete() async {
    auth.currentUser!.delete();
    getUser();
  }

  getToken() async {
    await api
        .getToken()
        .then((String result) => {
              token = result,
            })
        .catchError((error) => debugPrint('ERROR:' + error));
  }

  setToken() async {
    await getToken();
    await api
        .getUser(auth.currentUser!.email)
        .then((_user) async => {
              UserClass().add({
                'id': _user.docs.first['id'],
                'date': _user.docs.first['date'],
                'name': _user.docs.first['name'],
                'upDateName': _user.docs.first['upDateName'],
                'status': _user.docs.first['status'],
                'email': _user.docs.first['email'],
                'channel': _user.docs.first['channel'],
                'token': _user.docs.first['token'],
                'isNotification': _user.docs.first['isNotification'],
                'qtyHistory': _user.docs.first['qtyHistory'],
                'qtyComment': _user.docs.first['qtyComment'],
              }),
              if (token != null && currentUser.value.isNotEmpty)
                await api.setToken(token: token)
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
      await setToken();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException('email não encontrado. Cadastre-se.');
      } else if (e.code == 'wrong-password') {
        throw AuthException('senha incorreta. Tente novamente');
      }
    }
  }
}
