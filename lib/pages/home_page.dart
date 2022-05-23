import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:universe_history_app/components/all_for_now_component.dart';
import 'package:universe_history_app/components/history_list_component.dart';
import 'package:universe_history_app/components/icon_component.dart';
import 'package:universe_history_app/components/logo_component.dart';
import 'package:universe_history_app/components/menu_component.dart';
import 'package:universe_history_app/core/variables.dart';
import 'package:universe_history_app/models/history_model.dart';
import 'package:universe_history_app/models/user_model.dart';
import 'package:universe_history_app/services/local_notification_service.dart';
import 'package:universe_history_app/services/push_notification_service.dart';
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

  @override
  void initState() {
    super.initState();
    initilizeFirebaseMessaging();
    checkNotifications();
    DeviceUtil();
  }

  initilizeFirebaseMessaging() async {
    await Provider.of<PushNotificationService>(context, listen: false)
        .initialize();
  }

  checkNotifications() async {
    await Provider.of<LocalNotificationService>(context, listen: false)
        .checkForNotifications();
  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
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
                LogoComponent(size: 20, callback: (value) => _scrollToTop())
              ],
            ),
          ),
          actions: [
            // IconComponent(
            //   icon: UiSvg.search,
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
                                const IconComponent(
                                    icon: UiSvg.notification,
                                    route: 'notification'),
                                if (currentNotification.value)
                                  const Positioned(
                                    top: 10,
                                    right: 12,
                                    child: CircleAvatar(
                                      radius: 4,
                                      backgroundColor: UiColor.first,
                                    ),
                                  ),
                              ],
                            );
                          },
                        ),
                      )
                    : Container();
              },
            ),
            const IconComponent(icon: UiSvg.menu, route: 'settings'),
            const SizedBox(width: 10)
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: UiColor.first,
          elevation: 0,
          child: SvgPicture.asset(UiSvg.create),
          onPressed: () => {
            currentHistory.value = [],
            Navigator.of(context)
                .pushNamed(currentUser.value.isNotEmpty ? "/create" : "/login")
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(UiBorder.rounded),
          ),
        ),
        body: Container(
          color: UiColor.comp_1,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MenuComponent(),
                const SizedBox(height: 10),
                const Flexible(child: HistoryListComponent()),
                const AllForNowComponent()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
