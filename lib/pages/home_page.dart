// ignore_for_file: unnecessary_new, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import 'package:universe_history_app/components/call_create_component.dart';
import 'package:universe_history_app/shared/models/history_model.dart';
import 'package:universe_history_app/theme/ui_colors.dart';

class HomePage extends StatelessWidget {
  final _scrollController = ScrollController();
  List<HistoryModel> allHistory = HistoryModel.allHistory;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: uiColor.second,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      appBar: ScrollAppBar(
        controller: _scrollController, // Note the controller here
        title: Text("App Bar"),
      ),
      body: Snap(
        controller: _scrollController.appBar, // Controller is also here
        child: Container(
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 200,
                  child: CallCreate(),
                ),
                Flexible(
                  child: ListView.builder(
                    itemCount: 15,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => ListTile(
                      title: Text("List $index"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
//HistoryItemComponent(allHistory),
//CallCreate(),