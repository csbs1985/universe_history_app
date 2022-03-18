// ignore_for_file: unnecessary_new, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, use_key_in_widget_constructors, must_be_immutable, prefer_final_fields, unused_element, curly_braces_in_flow_control_structures, unnecessary_null_comparison

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:universe_history_app/components/btn_create_component.dart';
import 'package:universe_history_app/components/history_list_component.dart';
import 'package:universe_history_app/components/icon_component.dart';
import 'package:universe_history_app/components/logo_component.dart';
import 'package:universe_history_app/components/menu_component.dart';
import 'package:universe_history_app/core/variables.dart';
import 'package:universe_history_app/shared/models/user_model.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();

  bool _notification = true;
  String _itemSelectedMenu = 'todas';

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
                  color: uiColor.icon_2,
                  size: 20,
                  callback: (value) => _scrollToTop(),
                ),
              ],
            ),
          ),
          actions: [
            IconComponent(
              icon: uiSvg.search,
              color: uiColor.icon_2,
              route: 'search',
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Stack(
                children: [
                  IconComponent(
                    icon: uiSvg.notification,
                    color: uiColor.icon_2,
                    route: 'notification',
                  ),
                  if (_notification)
                    Positioned(
                      top: 10,
                      right: 12,
                      child: CircleAvatar(
                        radius: 4,
                        backgroundColor: uiColor.warning,
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconComponent(
                icon: uiSvg.menu,
                color: uiColor.icon_2,
                route: 'settings',
              ),
            ),
          ],
        ),
        body: Container(
          color: uiColor.comp_1,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MenuComponent(),
                ValueListenableBuilder(
                  valueListenable: menuItemSelected,
                  builder: (context, value, __) {
                    return Container(
                      child: _showCard(menuItemSelected.value.id)
                          ? Padding(
                              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                              child: Container(
                                child: ValueListenableBuilder<List<UserModel>>(
                                  valueListenable: currentUser,
                                  builder: (context, result, __) {
                                    return result.isNotEmpty
                                        ? BtnIconComponent(
                                            label:
                                                'Conte sua história, ${currentUser.value.first.nickname}',
                                            icon: uiSvg.create,
                                            callback: (value) =>
                                                Navigator.of(context)
                                                    .pushNamed("/create"),
                                          )
                                        : BtnIconComponent(
                                            label: 'Entre ou crie sua conta',
                                            icon: uiSvg.account,
                                            callback: (valeu) =>
                                                Navigator.of(context)
                                                    .pushNamed("/login"),
                                          );
                                  },
                                ),
                              ),
                            )
                          : SizedBox(),
                    );
                  },
                ),
                Flexible(
                  child:
                      HistoryListComponent(itemSelectedMenu: _itemSelectedMenu),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
