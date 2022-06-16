import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:universe_history_app/firestore/token_firestore.dart';
import 'package:universe_history_app/firestore/users_firestore.dart';
import 'package:universe_history_app/models/user_model.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
  final TokenFirestore tokenFirestore = TokenFirestore();
  final UsersFirestore usersFirestore = UsersFirestore();

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
    await tokenFirestore
        .getToken()
        .then((String result) => token = result)
        .catchError((error) => debugPrint('ERROR => getToken:' + error));
  }

  setToken() async {
    await getToken();
    await usersFirestore
        .getUserEmail(auth.currentUser!.email!)
        .then((_user) async => {
              UserClass().add({
                'id': _user.docs[0]['id'],
                'date': _user.docs[0]['date'],
                'name': _user.docs[0]['name'],
                'upDateName': _user.docs[0]['upDateName'],
                'status': UserStatus.ACTIVE.name,
                'email': _user.docs[0]['email'],
                'token': token,
                'isNotification': _user.docs[0]['isNotification'],
                'qtyHistory': _user.docs[0]['qtyHistory'],
                'qtyComment': _user.docs[0]['qtyComment'],
              }),
              if (token != null && currentUser.value.isNotEmpty)
                await usersFirestore.pathLoginLogout(
                  UserStatus.ACTIVE.name,
                  token: token,
                )
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
