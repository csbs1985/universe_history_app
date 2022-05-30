import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:universe_history_app/components/divider_component.dart';
import 'package:universe_history_app/components/history_item_component.dart';
import 'package:universe_history_app/components/icon_component.dart';
import 'package:universe_history_app/components/logo_component.dart';
import 'package:universe_history_app/components/menu_component.dart';
import 'package:universe_history_app/components/no_history_component.dart';
import 'package:universe_history_app/components/skeleton_history_item_component.dart';
import 'package:universe_history_app/core/api.dart';
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
  final Api api = Api();
  final ScrollController _scrollController = ScrollController();

  final List<HistoryModel> _data = [];

  bool loading = false;
  bool _isLoading = false;

  DocumentSnapshot? _lastDocument;

  static const PAGE_SIZE = 10;

  @override
  void initState() {
    super.initState();
    initilizeFirebaseMessaging();
    checkNotifications();
    DeviceUtil();
    _getContent();
    _scrollController.addListener(inifiniteScrolling);
  }

  inifiniteScrolling() {
    var triggerFetchMoreSize =
        _scrollController.position.maxScrollExtent * 0.20;

    if (_scrollController.position.pixels > triggerFetchMoreSize && !loading)
      _getContent();
  }

  initilizeFirebaseMessaging() async {
    await Provider.of<PushNotificationService>(context, listen: false)
        .initialize();
  }

  Future<void> _getContent() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    final value = menuItemSelected.value.id!;

    Query _query;
    if (value == 'todas' || value.isEmpty) {
      _query = FirebaseFirestore.instance
          .collection('historys')
          .orderBy('date', descending: true);
    } else if (value == 'minhas') {
      _query = FirebaseFirestore.instance
          .collection('historys')
          .where('userId', isEqualTo: currentUser.value.first.id)
          .orderBy('date', descending: true);
    } else if (value == 'salvas') {
      _query = FirebaseFirestore.instance.collection('bookmarks').where('user',
          arrayContainsAny: [
            currentUser.value.first.id
          ]).orderBy('date', descending: true);
    } else {
      _query = FirebaseFirestore.instance.collection('historys').where(
          'categories',
          arrayContainsAny: [value]).orderBy('date', descending: true);
    }

    _query = _lastDocument != null
        ? _query.startAfterDocument(_lastDocument!).limit(PAGE_SIZE)
        : _query.limit(PAGE_SIZE);

    final List<HistoryModel> pagedData = await _query.get().then((value) {
      _lastDocument = value.docs.isNotEmpty ? value.docs.last : null;

      return value.docs
          .map((e) => HistoryModel.fromMap(e.data() as Map<String, dynamic>))
          .toList();
    });

    setState(() {
      _data.addAll(pagedData);
      if (pagedData.length < PAGE_SIZE) loading = true;
      _isLoading = false;
    });
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
  void dispose() {
    super.dispose();
    _scrollController.dispose();
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
                Flexible(child: _list())
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _list() {
    return Container(
      child: _data.isEmpty
          ? _noResult()
          : ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _data.length + (loading ? 0 : 1),
              separatorBuilder: (_, __) => const DividerComponent(
                left: 16,
                right: 16,
                bottom: 10,
              ),
              itemBuilder: (BuildContext context, int index) {
                if (index == _data.length) {
                  return const SkeletonHistoryItemComponent();
                } else {
                  final item = _data[index];
                  return HistoryItemComponent(data: item);
                }
              },
            ),
    );
  }

  Widget _noResult() {
    return const NoResultComponent(
        text:
            'Não encontramos histórias que atendam sua pesquisa. Mas não desista, temos muitas outras histórias para você interagir.');
  }
}
