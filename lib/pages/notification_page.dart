// ignore_for_file: iterable_contains_unrelated_type, avoid_print, non_constant_identifier_names, constant_identifier_names, unnecessary_brace_in_string_interps, curly_braces_in_flow_control_structures

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';
import 'package:universe_history_app/components/appbar_back_component.dart';
import 'package:universe_history_app/components/no_history_component.dart';
import 'package:universe_history_app/components/resume_component.dart';
import 'package:universe_history_app/components/skeleton_notification_componen.dart';
import 'package:universe_history_app/components/title_component.dart';
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/core/variables.dart';
import 'package:universe_history_app/shared/models/notification_model.dart';
import 'package:universe_history_app/shared/models/user_model.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';
import 'package:universe_history_app/utils/edit_date_util.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final Api api = Api();
  final ScrollController _scrollController = ScrollController();

  final List<NotificationModel> _data = [];

  static const PAGE_SIZE = 10;

  bool _allFetched = false;
  bool _isLoading = false;

  DocumentSnapshot? _lastDocument;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => currentNotification.value = false);

    _getContent();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !_allFetched) {
        _getContent();
      }
    });
  }

  Future<void> _getContent() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    Query _query = FirebaseFirestore.instance
        .collection('notifications')
        .where('idUser', isEqualTo: currentUser.value.first.id)
        .orderBy('date', descending: true);

    _query = _lastDocument != null
        ? _query.startAfterDocument(_lastDocument!).limit(PAGE_SIZE)
        : _query.limit(PAGE_SIZE);

    final List<NotificationModel> pagedData = await _query.get().then((value) {
      _lastDocument = value.docs.isNotEmpty ? value.docs.last : null;

      return value.docs
          .map((e) =>
              NotificationModel.fromMap(e.data() as Map<String, dynamic>))
          .toList();
    });

    setState(() {
      _data.addAll(pagedData);
      if (pagedData.length < PAGE_SIZE) _allFetched = true;
      _isLoading = false;
    });
  }

  Future<void> _readNotification(_history) async {
    if (!_history.view) {
      await api.upNotification(_history.id);
      setState(() => _history.view = true);
    }
    Navigator.pushNamed(context, '/history', arguments: _history.idContent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppbarBackComponent(),
        body: SingleChildScrollView(
            controller: _scrollController,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TitleComponent(title: 'Notificações')),
              NotificationListener<ScrollEndNotification>(
                  child: _data.isEmpty
                      ? _noResult()
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _data.length + (_allFetched ? 0 : 1),
                          itemBuilder: (BuildContext context, int index) {
                            if (index == _data.length) {
                              return const SkeletonNotificationComponent();
                            } else {
                              final item = _data[index];
                              return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                        child: Container(
                                            width: double.infinity,
                                            color: item.view
                                                ? uiColor.comp_1
                                                : uiColor.second,
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        20, 4, 20, 4),
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      _comment(item),
                                                      ResumeComponent(
                                                          resume: editDateUtil(
                                                              item.date))
                                                    ]))),
                                        onTap: () => _readNotification(item))
                                  ]);
                            }
                          }))
            ])));
  }

  Widget _comment(index) {
    var _status = index.status;
    var _text = '';

    if (_status == NotificationEnum.COMMENT_ANONYMOUS.toString())
      _text =
          'Sua história <em>${index.content}</em> recebeu um comentário "<em>anônimo</em>".';

    if (_status == NotificationEnum.COMMENT_SIGNED.toString())
      _text =
          '<em>${index.nickName}</em> fez um comentou na história "<em>${index.content}</em>".';

    if (_status == NotificationEnum.COMMENT_MENTIONED.toString())
      _text =
          '<em>${index.nickName}</em> mencionou você em um comentário da história "<em>${index.content}</em>".';

    return StyledText(
        style: uiTextStyle.text1,
        tags: {'em': StyledTextTag(style: uiTextStyle.text10)},
        text: _text);
  }

  Widget _noResult() {
    return const NoResultComponent(
        text: 'Não há ou encontramos notificações no momento.');
  }
}

enum NotificationEnum { COMMENT_SIGNED, COMMENT_ANONYMOUS, COMMENT_MENTIONED }
