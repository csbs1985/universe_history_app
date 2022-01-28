// ignore_for_file: unnecessary_new, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, use_key_in_widget_constructors, must_be_immutable, prefer_final_fields

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import 'package:universe_history_app/components/card_component.dart';
import 'package:universe_history_app/components/history_item_component.dart';
import 'package:universe_history_app/components/menu_category_component.dart';
import 'package:universe_history_app/components/skeleton_history_item_component.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_image.dart';
import 'package:universe_history_app/theme/ui_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();

  bool _isLoading = true;
  bool _notification = true;
  bool _login = true;

  String _itemSelectedMenu = 'todas';

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() => _isLoading = false);
    });
    super.initState();
  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: Duration(milliseconds: 300), curve: Curves.linear);
  }

  void _selectMenu(value) {
    setState(() {
      _itemSelectedMenu = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: uiColor.first,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: uiColor.comp_1,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );

    return WillPopScope(
      onWillPop: () => exit(0),
      child: Scaffold(
        appBar: ScrollAppBar(
          backgroundColor: uiColor.first,
          controller: _scrollController,
          automaticallyImplyLeading: false,
          elevation: 0,
          titleSpacing: 10,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _scrollToTop,
                child: Image.asset(
                  uiImage.logo,
                  height: 28,
                ),
              ),
              Row(
                children: [
                  Stack(
                    children: [
                      IconButton(
                        icon: SvgPicture.asset(uiSvg.notification),
                        onPressed: () {
                          Navigator.of(context).pushNamed("/notification");
                        },
                      ),
                      if (_notification)
                        Positioned(
                          top: 8,
                          right: 12,
                          child: CircleAvatar(
                            radius: 4,
                            backgroundColor: uiColor.warning,
                          ),
                        ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed("/settings");
                    },
                    icon: SvgPicture.asset(uiSvg.options),
                  ),
                ],
              )
            ],
          ),
        ),
        body: Snap(
          controller: _scrollController.appBar,
          child: _isLoading
              ? Column(
                  children: [
                    for (var i = 0; i < 3; i++) SkeletonHistoryItemComponent()
                  ],
                )
              : Container(
                  color: uiColor.comp_1,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 44,
                          child: MenuCategoryComponent(
                            callback: (value) => _selectMenu(value),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          child: _login
                              ? CardComponent(
                                  title: 'Escreva sua história',
                                  text:
                                      'Todos nós temos uma história pra contar e a sua pode ajudar alguém.',
                                  label: 'Escrever',
                                )
                              : CardComponent(
                                  title: 'Entre ou crie sua conta',
                                  text:
                                      'Você não se identificou ainda para escrever histórias e comentarios.',
                                  label: 'Entrar',
                                ),
                          onTap: () => _login
                              ? Navigator.of(context).pushNamed("/create")
                              : Navigator.of(context).pushNamed("/login"),
                        ),
                        Flexible(
                          child: HistoryItemComponent(
                              itemSelectedMenu: _itemSelectedMenu),
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
