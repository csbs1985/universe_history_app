import 'package:flutter/material.dart';
import 'package:universe_history_app/components/appbar_back_component.dart';
import 'package:universe_history_app/components/comment_component.dart';
import 'package:universe_history_app/core/variables.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryItemPageState();
}

class _HistoryItemPageState extends State<HistoryPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarBackComponent(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Text(
              currentHistory.value,
              style: uiTextStyle.header1,
            ),
            CommentComponent(),
          ],
        ),
      ),
    );
  }
}
