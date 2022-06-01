import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:universe_history_app/models/user_model.dart';
import 'package:universe_history_app/services/realtime_database_service.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
  final RealtimeDatabaseService db = RealtimeDatabaseService();

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
    await db
        .getToken()
        .then((String result) => {
              token = result,
            })
        .catchError((error) => debugPrint('ERROR => getToken:' + error));
  }

  setToken() async {
    await getToken();
    await db
        .getUserEmail(auth.currentUser!.email!)
        .then((_user) async => {
              UserClass().add({
                'id': _user.children.single.value['id'],
                'date': _user.children.single.value['date'],
                'name': _user.children.single.value['name'],
                'upDateName': _user.children.single.value['upDateName'],
                'status': _user.children.single.value['status'],
                'email': _user.children.single.value['email'],
                'token': _user.children.single.value['token'],
                'isNotification': _user.children.single.value['isNotification'],
                'qtyHistory': _user.children.single.value['qtyHistory'],
                'qtyComment': _user.children.single.value['qtyComment'],
              }),
              if (token != null && currentUser.value.isNotEmpty)
                await db.pathToken(currentUser.value.first.id, token: token)
            })
        .catchError((error) => debugPrint('ERROR => setToken:' + error));
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
