import 'package:flutter/material.dart';
import 'package:universe_history_app/components/appbar_back_component.dart';

class HistoryItemPage extends StatelessWidget {
  const HistoryItemPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarBackComponent(),
      body: SingleChildScrollView(
        child: Stack(
          children: const [
            Text('texto'),
          ],
        ),
      ),
    );
  }
}
