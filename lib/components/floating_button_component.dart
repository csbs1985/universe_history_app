import 'package:flutter/material.dart';

class FloatingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.plus_one),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        onPressed: () => {},
      ),
    );
  }
}
