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

  @override
  void initState() {
    setState(() => currentNotification.value = false);
    super.initState();
  }

  void _readNotification(history) {
    api
        .upNotification(history['id'])
        .then((result) => {
              Navigator.pushNamed(context, '/history',
                  arguments: history['idContent']),
            })
        .catchError((error) => print('ERROR: ' + error));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarBackComponent(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TitleComponent(title: 'Notificações')),
            StreamBuilder(
              stream: api.getAllNotification(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return _noResult();
                  case ConnectionState.waiting:
                    return const SkeletonNotificationComponent();
                  case ConnectionState.done:
                  default:
                    try {
                      return _list(context, snapshot);
                    } catch (e) {
                      return _noResult();
                    }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _list(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    List<QueryDocumentSnapshot<dynamic>> documents = snapshot.data!.docs;
    return documents.isNotEmpty
        ? ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            reverse: true,
            itemCount: documents.length,
            itemBuilder: (BuildContext context, int index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  child: Container(
                    width: double.infinity,
                    color: documents[index]['view']
                        ? uiColor.comp_1
                        : uiColor.second,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 4, 20, 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _comment(documents[index]),
                          ResumeComponent(
                            resume: editDateUtil(
                                DateTime.parse(documents[index]['date'])
                                    .millisecondsSinceEpoch),
                          )
                        ],
                      ),
                    ),
                  ),
                  onTap: () => _readNotification(documents[index]),
                ),
              ],
            ),
          )
        : _noResult();
  }

  Widget _comment(index) {
    var _status = index['status'];
    var _text = '';

    if (_status == NotificationEnum.COMMENT_ANONYMOUS.toString())
      _text =
          'Sua história <em>${index['content']}</em> recebeu um comentário "<em>anônimo</em>".';

    if (_status == NotificationEnum.COMMENT_SIGNED.toString())
      _text =
          '<em>${index['nickName']}</em> fez um comentou na história "<em>${index['content']}</em>".';

    if (_status == NotificationEnum.COMMENT_MENTIONED.toString())
      _text =
          '<em>${index['nickName']}</em> mencionou você em um comentário da história "<em>${index['content']}</em>".';

    return StyledText(
      style: uiTextStyle.text1,
      tags: {'em': StyledTextTag(style: uiTextStyle.text10)},
      text: _text,
    );
  }

  Widget _noResult() {
    return const NoResultComponent(
        text: 'Não encontramos notificações no momento.');
  }
}

enum NotificationEnum { COMMENT_SIGNED, COMMENT_ANONYMOUS, COMMENT_MENTIONED }
