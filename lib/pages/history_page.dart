// ignore_for_file: prefer_typing_uninitialized_variables, unnecessary_new

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:universe_history_app/components/appbar_back_component.dart';
import 'package:universe_history_app/components/history_item_component.dart';
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/core/variables.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryItemPageState();
}

class _HistoryItemPageState extends State<HistoryPage> {
  final Api api = new Api();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarBackComponent(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // HistoryItemComponent(api.getAllHistoryFiltered(currentHistory.value)),
            // CommentComponent(),
          ],
        ),
      ),
    );
  }
}
