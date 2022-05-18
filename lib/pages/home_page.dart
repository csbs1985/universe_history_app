// ignore_for_file: unnecessary_new, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, use_key_in_widget_constructors, must_be_immutable, prefer_final_fields, unused_element, curly_braces_in_flow_control_structures, unnecessary_null_comparison

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universe_history_app/components/all_for_now_component.dart';
import 'package:universe_history_app/components/history_list_component.dart';
import 'package:universe_history_app/components/icon_component.dart';
import 'package:universe_history_app/components/logo_component.dart';
import 'package:universe_history_app/components/menu_component.dart';
import 'package:universe_history_app/core/variables.dart';
import 'package:universe_history_app/shared/models/history_model.dart';
import 'package:universe_history_app/shared/models/user_model.dart';
import 'package:universe_history_app/theme/ui_border.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_svg.dart';
import 'package:universe_history_app/utils/device_util.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();

  String _itemSelectedMenu = 'todas';

  @override
  void initState() {
    DeviceUtil();
    super.initState();
  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: Duration(milliseconds: 300), curve: Curves.linear);
  }

  bool _showCard(String? category) {
    return category == 'todas' ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => exit(0),
        child: Scaffold(
            appBar: AppBar(
              leadingWidth: double.infinity,
              automaticallyImplyLeading: false,
              elevation: 0,
              toolbarHeight: 54,
              leading: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        LogoComponent(
                            size: 20, callback: (value) => _scrollToTop())
                      ])),
              actions: [
                // IconComponent(
                //   icon: uiSvg.search,
                //   route: 'search',
                // ),
                ValueListenableBuilder(
                  valueListenable: currentUser,
                  builder: (BuildContext context, value, __) {
                    return currentUser.value.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: ValueListenableBuilder(
                                valueListenable: currentNotification,
                                builder: (BuildContext context, value, __) {
                                  return Stack(
                                    children: [
                                      IconComponent(
                                          icon: uiSvg.notification,
                                          route: 'notification'),
                                      if (currentNotification.value)
                                        Positioned(
                                            top: 10,
                                            right: 12,
                                            child: CircleAvatar(
                                                radius: 4,
                                                backgroundColor: uiColor.first))
                                    ],
                                  );
                                }))
                        : Container();
                  },
                ),
                IconComponent(icon: uiSvg.menu, route: 'settings'),
                SizedBox(width: 10)
              ],
            ),
            floatingActionButton: FloatingActionButton(
                backgroundColor: uiColor.first,
                elevation: 0,
                child: SvgPicture.asset(uiSvg.create),
                onPressed: () => {
                      currentHistory.value = [],
                      Navigator.of(context).pushNamed(
                          currentUser.value.isNotEmpty ? "/create" : "/login")
                    },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(uiBorder.rounded))),
            body: Container(
                color: uiColor.comp_1,
                child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MenuComponent(),
                          SizedBox(height: 10),
                          Flexible(
                              child: HistoryListComponent(
                                  itemSelectedMenu: _itemSelectedMenu)),
                          AllForNowComponent()
                        ])))));
  }
}
