// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:universe_history_app/pages/home_page.dart';
import 'package:universe_history_app/pages/login/login_page.dart';
import 'package:universe_history_app/services/auth_service.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  _AuthCheckState createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = AuthService();

    if (auth.isLoading)
      return loading();
    else if (auth.user == null)
      return const LoginPage();
    else
      return const HomePage();
  }

  loading() {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
