// ignore_for_file: unnecessary_new, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, use_key_in_widget_constructors, must_be_immutable

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import 'package:universe_history_app/components/call_create_component.dart';
import 'package:universe_history_app/components/history_item_component.dart';
import 'package:universe_history_app/components/menu_category_component.dart';
import 'package:universe_history_app/shared/models/history.dart';
import 'package:universe_history_app/theme/ui_colors.dart';
import 'package:universe_history_app/theme/ui_images.dart';

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

    return WillPopScope(
      onWillPop: () => exit(0),
      child: Scaffold(
        appBar: ScrollAppBar(
          controller: _scrollController,
          automaticallyImplyLeading: false,
          elevation: 0,
          titleSpacing: 10,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                uiImages.logo,
                height: 28,
              ),
            ],
          ),
        ),
        body: Snap(
          controller: _scrollController.appBar,
          child: Container(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 36,
                    child: MenuCategories(),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 145,
                    child: CallCreate(),
                  ),
                  Flexible(
                    child: HistoryItemComponent(allHistory),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
