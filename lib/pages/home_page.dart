// ignore_for_file: unnecessary_new, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, use_key_in_widget_constructors, must_be_immutable, prefer_final_fields

import 'dart:io';
import 'package:circle_button/circle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import 'package:universe_history_app/components/call_create_component.dart';
import 'package:universe_history_app/components/history_item_component.dart';
import 'package:universe_history_app/components/menu_category_component.dart';
import 'package:universe_history_app/components/skeleton_history_item.dart';
import 'package:universe_history_app/shared/models/history.dart';
import 'package:universe_history_app/theme/ui_colors.dart';
import 'package:universe_history_app/theme/ui_images.dart';
import 'package:universe_history_app/theme/ui_svgs.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  List<History> allHistory = History.allHistory;

  bool _isLoading = true;
  bool _notification = true;

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

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: uiColor.second,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _scrollToTop,
                child: Image.asset(
                  uiImages.logo,
                  height: 28,
                ),
              ),
              Row(
                children: [
                  CircleButton(
                      onTap: () {
                        Navigator.of(context).pushNamed("/notification");
                      },
                      width: 36,
                      height: 36,
                      child: SvgPicture.asset(uiSvg.notification),
                      borderWidth: 0,
                      borderColor: Colors.transparent,
                      backgroundColor:
                          _notification ? uiColor.comp_1 : uiColor.second),
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
                  children: [for (var i = 0; i < 3; i++) SkeletonHistoryItem()],
                )
              : Container(
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
                          height: 149,
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
